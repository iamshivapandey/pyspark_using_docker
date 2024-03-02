print("Hello from inside container")

from pyspark.sql import SparkSession
from pyspark.sql.types import StructType, StructField, StringType, IntegerType

# Create a SparkSession
spark = SparkSession.builder \
    .appName("Create DataFrame") \
    .getOrCreate()

# Define schema for the DataFrame
schema = StructType([
    StructField("Name", StringType(), True),
    StructField("Age", IntegerType(), True)
])

# Create data for the DataFrame
data = [("John", 30), ("Alice", 35), ("Bob", 40)]

# Create DataFrame
df = spark.createDataFrame(data, schema)

# Show DataFrame
df.show()

# Stop SparkSession
spark.stop()


