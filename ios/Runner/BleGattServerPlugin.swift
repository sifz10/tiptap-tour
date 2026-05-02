import Flutter
import CoreBluetooth

class BleGattServerPlugin: NSObject, FlutterPlugin, CBPeripheralManagerDelegate {

    private var channel: FlutterMethodChannel?
    private var peripheralManager: CBPeripheralManager?

    private var serviceUuid: CBUUID?
    private var messageWriteCharUuid: CBUUID?
    private var messageNotifyCharUuid: CBUUID?
    private var deviceInfoCharUuid: CBUUID?

    private var notifyCharacteristic: CBMutableCharacteristic?
    private var deviceId: String = ""
    private var displayName: String = ""
    private var connectedCentrals: [CBCentral] = []

    static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "com.ryven.tiptap_tour/ble_gatt_server",
            binaryMessenger: registrar.messenger()
        )
        let instance = BleGattServerPlugin()
        instance.channel = channel
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "startServer":
            guard let args = call.arguments as? [String: Any] else {
                result(FlutterError(code: "INVALID_ARGS", message: "Missing arguments", details: nil))
                return
            }
            deviceId = args["deviceId"] as? String ?? ""
            displayName = args["displayName"] as? String ?? ""
            serviceUuid = CBUUID(string: args["serviceUuid"] as! String)
            messageWriteCharUuid = CBUUID(string: args["messageWriteCharUuid"] as! String)
            messageNotifyCharUuid = CBUUID(string: args["messageNotifyCharUuid"] as! String)
            deviceInfoCharUuid = CBUUID(string: args["deviceInfoCharUuid"] as! String)

            peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
            result(nil)

        case "stopServer":
            peripheralManager?.stopAdvertising()
            peripheralManager?.removeAllServices()
            peripheralManager = nil
            connectedCentrals.removeAll()
            result(nil)

        case "startAdvertising":
            guard let args = call.arguments as? [String: Any],
                  let uuid = args["serviceUuid"] as? String else {
                result(FlutterError(code: "INVALID_ARGS", message: "Missing serviceUuid", details: nil))
                return
            }
            peripheralManager?.startAdvertising([
                CBAdvertisementDataServiceUUIDsKey: [CBUUID(string: uuid)],
                CBAdvertisementDataLocalNameKey: "TiptapTour"
            ])
            result(nil)

        case "stopAdvertising":
            peripheralManager?.stopAdvertising()
            result(nil)

        case "sendNotification":
            guard let args = call.arguments as? [String: Any],
                  let data = args["data"] as? FlutterStandardTypedData else {
                result(nil)
                return
            }
            let targetId = args["targetDeviceId"] as? String
            sendNotification(data: data.data, targetId: targetId)
            result(nil)

        default:
            result(FlutterMethodNotImplemented)
        }
    }

    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        guard peripheral.state == .poweredOn else { return }
        setupService()
    }

    private func setupService() {
        guard let serviceUuid = serviceUuid,
              let writeUuid = messageWriteCharUuid,
              let notifyUuid = messageNotifyCharUuid,
              let infoUuid = deviceInfoCharUuid else { return }

        let writeChar = CBMutableCharacteristic(
            type: writeUuid,
            properties: [.write, .writeWithoutResponse],
            value: nil,
            permissions: [.writeable]
        )

        let notifyChar = CBMutableCharacteristic(
            type: notifyUuid,
            properties: [.notify, .read],
            value: nil,
            permissions: [.readable]
        )
        self.notifyCharacteristic = notifyChar

        let infoData = "\(deviceId)|\(displayName)".data(using: .utf8)
        let infoChar = CBMutableCharacteristic(
            type: infoUuid,
            properties: [.read],
            value: infoData,
            permissions: [.readable]
        )

        let service = CBMutableService(type: serviceUuid, primary: true)
        service.characteristics = [writeChar, notifyChar, infoChar]

        peripheralManager?.add(service)
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, didReceiveWrite requests: [CBATTRequest]) {
        for request in requests {
            if request.characteristic.uuid == messageWriteCharUuid,
               let value = request.value {
                channel?.invokeMethod("onDataReceived", arguments: [
                    "centralId": request.central.identifier.uuidString,
                    "data": FlutterStandardTypedData(bytes: value)
                ])
            }
            peripheral.respond(to: request, withResult: .success)
        }
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didSubscribeTo characteristic: CBCharacteristic) {
        if !connectedCentrals.contains(where: { $0.identifier == central.identifier }) {
            connectedCentrals.append(central)
            channel?.invokeMethod("onCentralConnected", arguments: central.identifier.uuidString)
        }
    }

    func peripheralManager(_ peripheral: CBPeripheralManager, central: CBCentral, didUnsubscribeFrom characteristic: CBCharacteristic) {
        connectedCentrals.removeAll { $0.identifier == central.identifier }
        channel?.invokeMethod("onCentralDisconnected", arguments: central.identifier.uuidString)
    }

    private func sendNotification(data: Data, targetId: String?) {
        guard let char = notifyCharacteristic else { return }

        let targets: [CBCentral]
        if let targetId = targetId {
            targets = connectedCentrals.filter { $0.identifier.uuidString == targetId }
        } else {
            targets = connectedCentrals
        }

        for central in targets {
            peripheralManager?.updateValue(data, for: char, onSubscribedCentrals: [central])
        }
    }
}
