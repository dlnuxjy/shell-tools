#!/bin/sh  
if [ $# -ne 2 ] 
then
	echo "Usage :param error!"
	echo "cplib.sh exe searchPath"
	exit
fi 
exe=$1         #修改发布程序的名称
searchPath="$2"
des="." #修改输出可执行文件路径

#deplist=$(ldd $exe | awk  '{if (match($3,"/")){ printf("%s "),$3 } }')  
#cp $deplist $des
libs=`readelf -a ${exe}|grep Shared |cut -d "[" -f 2 | sed 's/.$//1'`
for file in ${libs}
do
onelib=`find ${searchPath} -name ${file}`
cp ${onelib} $des
echo $file"--->>>"${onelib}
done
echo "done"
