<#
This script creates VMs from a template.

Enter numbers of VMs, specify VMs name,
names of template, datastore and specification.
This script writes the activity log.
#>

#Input the path for log file
$PathLog = Read-Host "Enter the path for log file"
Start-Transcript -Path $PathLog -Append

#Input the first number of VM
Do {
	$FirstNum = Read-Host "The first number of VM"
}
While (-not ((1 -le $FirstNum) -and (999 -ge $FirstNum))){
}


#Input the last number of VM
Do {
	$LastNum = Read-Host "The last number of VM"
}
While (-not (($FirstNum -le $LastNum) -and (999 -ge $LastNum))){
}


#Count the number of VMs.
$VmNum = $LastNum - $FirstNum + 1
Write-Host $VmNum


#Input Prefix
$VMprefix = Read-Host "Type the prefix of the vm name"


#Input the resourcepoolname
Do {
	$Pool = Read-Host "The resourcepoolname"
}
While (-not ((1 -le $Pool) -and (999 -ge $Pool))){
}


#Input path to the template
$Template = Read-Host "The path to the template"


#Input the VM Customization Specification
$CustomSpecification = Read-Host "OSCustomizationSpec"

#Input the datastore
$DS = Read-Host "Datastore name"


#Input Virtual Machine folder
$Folder = Read-Host "Folder"


#Connect to viserver
$vCenter = Read-Host "vcenter"
$vCenterUser = Read-Host "user"
$vCenterPassword = Read-Host"password"
$Host = Read-Host "host"

Write-Host "Connecting to vCenter Server $vCenter"
Connect-VIServer -Server $vCenter -User $vCenterUser -Password $vCenterPassword

#Creating VMs
for ($i=1; $i -le $VmNum; $i++) {
	$VMname = $VMprefix + $Pool + "-" + '{0:d3}' -f $i
	Write-Host "Creation of VM $VMname initiated"
	New-VM -Name $VMname -Template $Template -VMHost $Host -Datastore $DS -Location $Folder -OSCustomizationSpec $CustomSpecification
	}

Stop-Transcript