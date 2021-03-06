#!/bin/bash

rows=(24 24 30 0)
sum=0

# total number of rows
for i in "${rows[@]}"; do
  sum=$((sum+i))
done

# generate config header
cat <<EOF
<?xml version="1.0"?>
<Config>
  <Cabinet Type="IrRegular">
    <Name>first-working</Name>
    <Width>192</Width>
    <Height>$sum</Height>
    <PhysicalDataGroupNum>128</PhysicalDataGroupNum>
    <MaxSumOfScanPointInGroup>48</MaxSumOfScanPointInGroup>
    <PointTableData />
    <ModuleList>
EOF

# generate led mappings
position=-1
for group in 0 1 2 3; do
start=$((group * 32))
end=$((start+rows[group]-1))

for i in $(seq $start $end); do
datagroup=$((i%2*64 + i/2))
position=$((position + 1))
cat <<EOF
      <Module>
        <Name>led bar</Name>
        <PixelCols>192</PixelCols>
        <PixelRows>1</PixelRows>
        <DataDirectType>Vertical</DataDirectType>
        <DriverChipType>Chip_CommonBase</DriverChipType>
        <DecType>Decode138</DecType>
        <OEPolarity>LowEnable</OEPolarity>
        <ScanType>Scan_4</ScanType>
        <TotalPointInTable>48</TotalPointInTable>
        <DataGroup>1</DataGroup>
        <PointTableData>3-0-7-0-11-0-15-0-19-0-23-0-27-0-31-0-35-0-39-0-43-0-47-0-51-0-55-0-59-0-63-0-67-0-71-0-75-0-79-0-83-0-87-0-91-0-95-0-99-0-103-0-107-0-111-0-115-0-119-0-123-0-127-0-131-0-135-0-139-0-143-0-147-0-151-0-155-0-159-0-163-0-167-0-171-0-175-0-179-0-183-0-187-0-191-0</PointTableData>
        <DataGroupSequence>0-1-2-3-4-5-6-7</DataGroupSequence>
        <ScanABCDCode>3-2-1-0-0-0-0-0-0-0-0-0-0-0-0-0</ScanABCDCode>
        <NewScanABCDCode>3-2-1-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0-0</NewScanABCDCode>
        <RGBCode>0-1-2-3</RGBCode>
        <RowsCtrlByDataGroup>192-192-192-192-192-192-192-192</RowsCtrlByDataGroup>
        <ModuleGroupInCabinet>${datagroup}*0</ModuleGroupInCabinet>
        <ModuleSize>192-1</ModuleSize>
        <ModulePosition>0-${position}</ModulePosition>
        <LineBias>3</LineBias>
        <ScreenDriveType>Serial</ScreenDriveType>
        <SerialColorNum>3</SerialColorNum>
        <SerialDotsNumPerColor>1</SerialDotsNumPerColor>
        <SerialRGBCode>0-1-2-3</SerialRGBCode>
        <StartPositionOfDataGroup>0-0-0-0-0-0-0-0</StartPositionOfDataGroup>
        <ModuleVersion>2.0</ModuleVersion>
      </Module>
EOF
done

done

# generate config footer
cat <<EOF
    </ModuleList>
  </Cabinet>
</Config>
EOF
