# react-native-brother-printing

React Native Brother Printing is a react-native module that will allow you to print labels on Brother printers via Wifi and Bluetooth.

## Getting started

`$ npm install react-native-brother-printing --save`

or

`$ yarn add react-native-brother-printing`

### Mostly automatic installation

`$ cd ios; pod install`

or if you are using React Native before version 0.60,

`$ react-native link react-native-brother-printing`

## Usage

### Permissions

Make sure to add the following permissions to your `Info.plist` file.

```xml
  <!-- for Bluetooth (iOS 13-) -->
	<key>NSBluetoothPeripheralUsageDescription</key>
  <string>Find paired Brother printers</string>

  <!-- for Bluetooth (iOS 13+) -->
	<key>NSBluetoothAlwaysUsageDescription</key>
	<string>Find paired Brother printers</string>

  <!-- for Wifi -->
  <key>NSLocalNetworkUsageDescription</key>
	<string>Find Brother printers installed in the local network.</string>
	<key>NSBonjourServices</key>
	<array>
		<string>_pdl-datastream._tcp</string>
		<string>_printer._tcp</string>
		<string>_ipp._tcp</string>
	</array>
```

### Printing via Bluetooth

To discover printers use the discoverPrinters function. You can pass in the option parameters `printerName` to change
the printer name, or V6 to enable ipv6 detection. Both parameters can be left blank.

```javascript
import { printImageViaBluetooth } from "react-native-brother-printing";

const modelName = 'QL-820NWB';

printImageViaBluetooth(imageUri, modelName)
```

### Printing via Wifi

```javascript
import { printImageViaWifi } from "react-native-brother-printing";

const ipAddress = '192.168.1.18';
const modelName = 'QL-820NWB';

printImageViaWifi(imageUri, ipAddress, modelName)
```

## Influence

This library is influenced by [react-native-brother-printers](https://github.com/Avery246813579/react-native-brother-printers).
