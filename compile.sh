sudo yum -y install java-1.8.0-openjdk-devel
sudo yum -y install wget
mkdir -p units
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-core/1.2.1/hadoop-core-1.2.1.jar
javac -classpath hadoop-core-1.2.1.jar -target 8 -source 8 -d units ProcessUnits.java
jar -cvf units.jar -C units/ .

mkdir -p lab && cd lab
hadoop fs -mkdir input_dir
hadoop fs -put /app/sample.txt input_dir
hadoop fs -ls input_dir/
hadoop jar /app/units.jar hadoop.ProcessUnits input_dir output_dir
hadoop fs -cat output_dir/part-00000
hdfs dfs -copyToLocal output_dir /app