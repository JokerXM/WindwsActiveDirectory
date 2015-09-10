Import-Module activedirectory
Set-ExecutionPolicy RemoteSigned
$AllUsers = Import-Csv C:\Users\Administrator\Desktop\3MSD_organization.csv -Delimiter ','
$country = "hehe"
$location = "haha"
$dept = "lala"

New-ADOrganizationalUnit -Name "Direction" -Path "DC=shiptruck,DC=lan" -verbose
New-ADOrganizationalUnit -Name "Agendes" -Path "DC=shiptruck,DC=lan" -verbose
foreach($user in $AllUsers){

if(($user.department -eq "Management") -or ($user.department -eq "Plateform Staff")){
        if($user.location -eq $location)
        {}
        else{
            $location = $user.location
             New-ADOrganizationalUnit -Name $location -Path "OU=Agendes,DC=shiptruck,DC=lan" -verbose
        }

        if($user.department -eq $dept)
        {}
        else{
                $dept= $user.department
                $groupname1 = "G"
                $groupname2 = $user.Location.substring(0,3).ToUpper()
                $groupname3 = $user.department
                $groupname4 = "R_"
                $groupname5 = "R_W_"

                $rgroupname = $groupname1 + "_" +$groupname2 + "_" + $groupname3 + "_" + $groupname4
                $rwgroupname = $groupname1 + "_" +$groupname2 + "_" + $groupname3 + "_" + $groupname5
                New-ADOrganizationalUnit -Name $user.department -Path "OU=$location,OU=Agendes,DC=shiptruck,DC=lan" -verbose
                New-ADOrganizationalUnit -Name "Users" -Path "OU=$dept,OU=$location,OU=Agendes,DC=shiptruck,DC=lan" -verbose
                New-ADOrganizationalUnit -Name "Groups" -Path "OU=$dept,OU=$location,OU=Agendes,DC=shiptruck,DC=lan" -verbose

                NEW-ADGroup –name $rgroupname –groupscope Global –path “OU=Groups,OU=$dept,OU=$location,OU=Agendes,DC=shiptruck,DC=lan” -Verbose
                NEW-ADGroup –name $rwgroupname –groupscope Global –path “OU=Groups,OU=$dept,OU=$location,OU=Agendes,DC=shiptruck,DC=lan” -Verbose
        }
       
    $login= $user.Firstname.substring(0,1)+"."+$user.Lastname
	$login.ToLower()
    $name = $user.Lastname
    $firstname = $user.Firstname
    $location = $user.location
    $department = $user.department
    $ou = "OU=Users,OU=$department,OU=$location,OU=Agendes,DC=shiptruck,DC=lan"
    New-ADUser -SamAccountName $login -Path $ou -Name $name -GivenName $firstname -City $location  
    Add-ADGroupMember $rgroupname $login
}
else{
        if($user.department -eq $dept)
        {}
        else{
                $dept= $user.department
                $groupname1 = "G"
                $groupname2 = $user.Location.substring(0,3).ToUpper()
                $groupname3 = $user.department
                $groupname4 = "R"
                $groupname5 = "RW"

                $rgroupname = $groupname1 + "_" +$groupname2 + "_" + $groupname3 + "_" + $groupname4
                $rwgroupname = $groupname1 + "_" +$groupname2 + "_" + $groupname3 + "_" + $groupname5
                New-ADOrganizationalUnit -Name $user.department -Path "OU=Direction,DC=shiptruck,DC=lan" -verbose
                New-ADOrganizationalUnit -Name "Users" -Path "OU=$dept,OU=Direction,DC=shiptruck,DC=lan" -verbose
                New-ADOrganizationalUnit -Name "Groups" -Path "OU=$dept,OU=Direction,DC=shiptruck,DC=lan" -verbose

                NEW-ADGroup –name $rgroupname –groupscope Global –path “OU=Groups,OU=$dept,OU=Direction,DC=shiptruck,DC=lan” -Verbose
                NEW-ADGroup –name $rwgroupname –groupscope Global –path “OU=Groups,OU=$dept,OU=Direction,DC=shiptruck,DC=lan” -Verbose
        }

    switch($user.country){
        "France" { $countryForAD = "FR"}
        "Germany" { $countryForAD = "DE"}
    }

       
    $login= $user.Firstname.substring(0,1)+"."+$user.Lastname
	$login.ToLower()
    $name = $user.Lastname
    $firstname = $user.Firstname
    $location = $user.location
    $department = $user.department
    $country = $user.country
    $ou = "OU=Users,OU=$department,OU=Direction,DC=shiptruck,DC=lan"
    New-ADUser -SamAccountName $login -Path $ou -Name $name -GivenName $firstname -City $location 
    Add-ADGroupMember $rgroupname $login
    } 
}

