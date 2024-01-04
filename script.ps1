# Variables
$vmName = "AlienVaultVM"
$isoPath = "C:\Users\toxicbot\Downloads\AlienVault_OSSIM_64bits.iso"
$vhdPath = "C:\Users\toxicbot\Downloads\AlienVault_OSSIM_64bits.vhd"
$ramSizeMB = 2048
$processorCount = 2
$networkAdapter = "Bridged"

# Full path to VBoxManage.exe
$VBoxManagePath = "C:\Program Files\Oracle\VirtualBox\VBoxManage.exe"

# Create VM
& $VBoxManagePath createvm --name $vmName --ostype "Windows10_64" --register

# Configure VM
& $VBoxManagePath modifyvm $vmName --memory $ramSizeMB --cpus $processorCount --boot1 dvd

# Attach ISO
& $VBoxManagePath storagectl $vmName --name "IDE Controller" --add ide
& $VBoxManagePath storageattach $vmName --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium $isoPath

# Create VHD
& $VBoxManagePath createhd --filename $vhdPath --size 20480

# Attach VHD
& $VBoxManagePath storagectl $vmName --name "SATA Controller" --add sata
& $VBoxManagePath storageattach $vmName --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium $vhdPath

# Start the VM
& $VBoxManagePath startvm $vmName
