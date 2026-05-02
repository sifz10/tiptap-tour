package com.ryven.tiptap_tour

import android.bluetooth.*
import android.bluetooth.le.AdvertiseCallback
import android.bluetooth.le.AdvertiseData
import android.bluetooth.le.AdvertiseSettings
import android.bluetooth.le.BluetoothLeAdvertiser
import android.content.Context
import android.os.ParcelUuid
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.util.UUID

class BleGattServerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {

    private lateinit var channel: MethodChannel
    private var context: Context? = null
    private var gattServer: BluetoothGattServer? = null
    private var advertiser: BluetoothLeAdvertiser? = null
    private var deviceId: String = ""
    private var displayName: String = ""

    private var messageWriteCharUuid: UUID? = null
    private var messageNotifyCharUuid: UUID? = null
    private var deviceInfoCharUuid: UUID? = null

    private var notifyCharacteristic: BluetoothGattCharacteristic? = null
    private val connectedDevices = mutableSetOf<BluetoothDevice>()

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        context = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "com.ryven.tiptap_tour/ble_gatt_server")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
        stopServer()
        context = null
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startServer" -> {
                val serviceUuid = call.argument<String>("serviceUuid")!!
                messageWriteCharUuid = UUID.fromString(call.argument<String>("messageWriteCharUuid")!!)
                messageNotifyCharUuid = UUID.fromString(call.argument<String>("messageNotifyCharUuid")!!)
                deviceInfoCharUuid = UUID.fromString(call.argument<String>("deviceInfoCharUuid")!!)
                deviceId = call.argument<String>("deviceId") ?: ""
                displayName = call.argument<String>("displayName") ?: ""
                startServer(UUID.fromString(serviceUuid), result)
            }
            "stopServer" -> {
                stopServer()
                result.success(null)
            }
            "startAdvertising" -> {
                val serviceUuid = call.argument<String>("serviceUuid")!!
                startAdvertising(UUID.fromString(serviceUuid), result)
            }
            "stopAdvertising" -> {
                stopAdvertising()
                result.success(null)
            }
            "sendNotification" -> {
                val data = call.argument<ByteArray>("data")!!
                val targetDeviceId = call.argument<String>("targetDeviceId")
                sendNotification(data, targetDeviceId)
                result.success(null)
            }
            else -> result.notImplemented()
        }
    }

    private fun startServer(serviceUuid: UUID, result: MethodChannel.Result) {
        val bluetoothManager = context?.getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager
        if (bluetoothManager == null) {
            result.error("BLE_UNAVAILABLE", "Bluetooth not available", null)
            return
        }

        gattServer = bluetoothManager.openGattServer(context, gattCallback)
        if (gattServer == null) {
            result.error("GATT_FAILED", "Failed to open GATT server", null)
            return
        }

        val service = BluetoothGattService(serviceUuid, BluetoothGattService.SERVICE_TYPE_PRIMARY)

        val writeChar = BluetoothGattCharacteristic(
            messageWriteCharUuid,
            BluetoothGattCharacteristic.PROPERTY_WRITE or BluetoothGattCharacteristic.PROPERTY_WRITE_NO_RESPONSE,
            BluetoothGattCharacteristic.PERMISSION_WRITE
        )

        notifyCharacteristic = BluetoothGattCharacteristic(
            messageNotifyCharUuid,
            BluetoothGattCharacteristic.PROPERTY_NOTIFY or BluetoothGattCharacteristic.PROPERTY_READ,
            BluetoothGattCharacteristic.PERMISSION_READ
        )
        val cccd = BluetoothGattDescriptor(
            UUID.fromString("00002902-0000-1000-8000-00805f9b34fb"),
            BluetoothGattDescriptor.PERMISSION_WRITE or BluetoothGattDescriptor.PERMISSION_READ
        )
        notifyCharacteristic!!.addDescriptor(cccd)

        val infoChar = BluetoothGattCharacteristic(
            deviceInfoCharUuid,
            BluetoothGattCharacteristic.PROPERTY_READ,
            BluetoothGattCharacteristic.PERMISSION_READ
        )
        infoChar.value = "$deviceId|$displayName".toByteArray(Charsets.UTF_8)

        service.addCharacteristic(writeChar)
        service.addCharacteristic(notifyCharacteristic)
        service.addCharacteristic(infoChar)

        gattServer?.addService(service)
        result.success(null)
    }

    private fun stopServer() {
        gattServer?.close()
        gattServer = null
        connectedDevices.clear()
    }

    private fun startAdvertising(serviceUuid: UUID, result: MethodChannel.Result) {
        val bluetoothManager = context?.getSystemService(Context.BLUETOOTH_SERVICE) as? BluetoothManager
        val adapter = bluetoothManager?.adapter
        advertiser = adapter?.bluetoothLeAdvertiser

        if (advertiser == null) {
            result.error("ADV_UNAVAILABLE", "BLE advertising not supported", null)
            return
        }

        val settings = AdvertiseSettings.Builder()
            .setAdvertiseMode(AdvertiseSettings.ADVERTISE_MODE_LOW_POWER)
            .setConnectable(true)
            .setTimeout(0)
            .setTxPowerLevel(AdvertiseSettings.ADVERTISE_TX_POWER_MEDIUM)
            .build()

        val data = AdvertiseData.Builder()
            .setIncludeDeviceName(false)
            .addServiceUuid(ParcelUuid(serviceUuid))
            .build()

        advertiser?.startAdvertising(settings, data, object : AdvertiseCallback() {
            override fun onStartSuccess(settingsInEffect: AdvertiseSettings?) {
                result.success(null)
            }

            override fun onStartFailure(errorCode: Int) {
                result.error("ADV_FAILED", "Advertising failed with code $errorCode", null)
            }
        })
    }

    private fun stopAdvertising() {
        advertiser?.stopAdvertising(object : AdvertiseCallback() {})
        advertiser = null
    }

    private fun sendNotification(data: ByteArray, targetDeviceId: String?) {
        val char = notifyCharacteristic ?: return
        char.value = data

        val targets = if (targetDeviceId != null) {
            connectedDevices.filter { it.address == targetDeviceId }
        } else {
            connectedDevices.toList()
        }

        for (device in targets) {
            gattServer?.notifyCharacteristicChanged(device, char, false)
        }
    }

    private val gattCallback = object : BluetoothGattServerCallback() {
        override fun onConnectionStateChange(device: BluetoothDevice, status: Int, newState: Int) {
            if (newState == BluetoothProfile.STATE_CONNECTED) {
                connectedDevices.add(device)
                channel.invokeMethod("onCentralConnected", device.address)
            } else if (newState == BluetoothProfile.STATE_DISCONNECTED) {
                connectedDevices.remove(device)
                channel.invokeMethod("onCentralDisconnected", device.address)
            }
        }

        override fun onCharacteristicWriteRequest(
            device: BluetoothDevice,
            requestId: Int,
            characteristic: BluetoothGattCharacteristic,
            preparedWrite: Boolean,
            responseNeeded: Boolean,
            offset: Int,
            value: ByteArray
        ) {
            if (characteristic.uuid == messageWriteCharUuid) {
                channel.invokeMethod("onDataReceived", mapOf(
                    "centralId" to device.address,
                    "data" to value.toList()
                ))
            }

            if (responseNeeded) {
                gattServer?.sendResponse(device, requestId, BluetoothGatt.GATT_SUCCESS, 0, null)
            }
        }

        override fun onCharacteristicReadRequest(
            device: BluetoothDevice,
            requestId: Int,
            offset: Int,
            characteristic: BluetoothGattCharacteristic
        ) {
            val value = when (characteristic.uuid) {
                deviceInfoCharUuid -> "$deviceId|$displayName".toByteArray(Charsets.UTF_8)
                else -> byteArrayOf()
            }

            val chunk = if (offset < value.size) value.copyOfRange(offset, value.size) else byteArrayOf()
            gattServer?.sendResponse(device, requestId, BluetoothGatt.GATT_SUCCESS, offset, chunk)
        }

        override fun onDescriptorWriteRequest(
            device: BluetoothDevice,
            requestId: Int,
            descriptor: BluetoothGattDescriptor,
            preparedWrite: Boolean,
            responseNeeded: Boolean,
            offset: Int,
            value: ByteArray
        ) {
            if (responseNeeded) {
                gattServer?.sendResponse(device, requestId, BluetoothGatt.GATT_SUCCESS, 0, null)
            }
        }
    }
}
