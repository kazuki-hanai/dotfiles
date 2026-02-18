# !/bin/bash
#
# create a file to work with
#
echo "creating a file to work with"
dd if=/dev/zero of=/var/tmp/infile count=1175000

for bs in  16m 32m 64m 128m 256m 512m

do
        echo "---------------------------------------"
        echo "Testing block size  = $bs"
        dd if=/var/tmp/infile of=/var/tmp/outfile bs=$bs
        echo ""
done
rm /var/tmp/infile /var/tmp/outfile
