
# encode&decode functions are borrowed from ArchWiki (USB 3G Modem)
encode ()
{
    perl -e '@a=split(//,unpack("b*","'"$1"'")); for ($i=7; $i < $#a; $i+=8) { $a[$i]="" } print uc(unpack("H*", pack("b*", join("", @a))))."\n"'
}

decode ()
{
    perl -e '@a=split(//,unpack("b*", pack("H*","'"$1"'"))); for ($i=6; $i < $#a; $i+=7) {$a[$i].="0" } print pack("b*", join("", @a)).""'
}

MODEM_INPUT_DEVICE=/dev/ttyUSB0
MODEM_OUTPUT_DEVICE=/dev/ttyUSB2

write_query ()
{
    echo "AT+CUSD=1,$1,15" | sudo tee $MODEM_INPUT_DEVICE > /dev/null
}

read_response ()
{
    sudo timeout 30 sudo grep -F -m 1 '+CUSD: 1,' $MODEM_OUTPUT_DEVICE | cut -d'"' -f2
}

