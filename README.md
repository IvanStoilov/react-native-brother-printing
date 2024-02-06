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

## Supported devices

The devices which are supported are PJ-763MFi, PJ-862, PJ-863, PJ-883, MW-145MFi, MW-260MFi, RJ-2050, RJ-2150, RJ-3050Ai, RJ-3150Ai, RJ-3230B, RJ-3250WB, RJ-4030Ai, RJ-4230B, RJ-4250WB, QL-820NWB, QL-820NWBc, QL-1110NWB, QL-1110NWBc, TD-2125NWB, TD-2135NWB, TD-4550DNWB, PT-P910BT, RJ-2035B, RJ-3035B.
```

## Influence

This library is influenced by [react-native-brother-printers](https://github.com/Avery246813579/react-native-brother-printers).

`react-native-brother-printing` is just a wrapper around the native library from Brother. More info here - https://support.brother.com/g/s/es/dev/en/mobilesdk/download/index.html?c=eu_ot&lang=en&navi=offall&comple=on&redirect=on#iphone.

For more SDK's check out this page - https://developerprogram.brother-usa.com/sdk-download#largepromo7
