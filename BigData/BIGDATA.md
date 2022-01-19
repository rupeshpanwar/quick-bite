     BIG DATA HADOOP

    INTRODUCTION

        What is Big Data?
        What is Hadoop?
        Need of Hadoop
        Sources and Types of Data
        Comparison with Other Technologies
        Challenges with Big Data
            i. Storage
            ii. Processing
        RDBMS vs Hadoop
        Advantages of Hadoop
        Hadoop Echo System components

    HDFS (Hadoop Distributed File System)

        Features of HDFS
        Name node ,Data node ,Blocks
        Configuring Block size,
        HDFS Architecture ( 5 Daemons)
            i. Name Node
            ii. Data Node
            iii. Secondary Name node
            iv. Job Tracker
            v. Task Tracker
        Metadata management
        Storage and processing
        Replication in Hadoop
        Configuring Custom Replication
        Fault Tolerance in Hadoop
        HDFS Commands

    MAP REDUCE

        Map Reduce Architecture
        Processing Daemons of Hadoop
            Job Tracker (Roles and Responsibilities)
            Task Tracker(Roles and Responsibilities)
        Phases of Map Reduce
            i) Mapper phase
            ii) Reducer phase
        Input split
        Input split vs Block size
        Partitioner in Map Reduce
        Groupings and Aggregations
        Data Types in Map Reduce
        Map Reduce Programming Model
            Driver Code
            Mapper Code
            Reducer Code
        Programming examples
        File input formats
        File output formats
        Merging in Map Reduce
        Speculative Execution Model
        Speculative Job

    SQOOP (SQL + HADOOP)

        Introduction to Sqoop
        SQOOP Import
        SQOOP Export
        Importing Data From RDBMS to HDFS
        Importing Data From RDBMS to HIVE
        Importing Data From RDBMS to HBASE
        Exporting From HASE to RDBMS
        Exporting From HBASE to RDBMS
        Exporting From HIVE to RDBMS
        Exporting From HDFS to RDBMS
        Transformations While Importing / Exporting
        Filtering data while importing
        Vertical and Horizontal merging while import
        Working with delimiters while importing
        Groupings and Aggregations while import
        Incremental import
        Examples and operations
        Defining SQOOP Jobs

    YARN

        Introduction
        Speculative Execution ,Speculative job and
        Speculative Task.
        Comparision of Hadoop1.xx with Hadoop2.xx
        Comparision with previous versions
        YARN Architecture Componets
            i. Resource Manager
            ii. Application Master
            iii. Node Manager
            iv. Application Manager
            v. Resource Scheduler
            vi. Job History Server
            vii. Container

    PIG

        Introduction to pig
        Pig Advantages
        Pig Latin Script
        Pig Terminologies
        Pig Relations, Bags, Tuples, Fields
        Pig Console / Grunt Shell
        Pig Execution Modes
        Pig Data Types
        Nulls
        Constants
        Expressions
        Schemas
        Parameter Substitution
        Arithmetic Operators
        Comparison Operators
        Null Operators
        Boolean Operators
        Sign Operators
        Flatten Operators
        Transformations in Pig
        Generating New Fields
        Type cating
        Filter Transformation
        Eliminating nulls and duplicates
        Data Merging
        UNION, JOINS in pig

    Relational Operators in Pig

        COGROUP
        CROSS
        DISTINCT
        FILTER
        FOREACH
        GROUP
        JOIN (INNER)
        JOIN (OUTER)
        LIMIT
        LOAD
        ORDER
        SAMPLE
        SPILT
        STORE
        UNION

    Diagnostic Operators in Pig

        Describe
        Dump
        Explain
        Illustrate

    Eval Functions in Pig

        AVG
        CONCAT
        COUNT
        DIFF
        IS EMPTY
        MAX
        MIN
        SIZE
        SUM
        TOKENIZE
        Submitting Pig Scripts
        writing Custom UDFS in Pig

    HIVE

        Introduction
        Hive Architecture
        Hive Metastore
        Hive Query Launguage
        Difference between HQL and SQL
        Hive Built in Functions
        Loading Data From Local Files To Hive Tables
        Loading Data From Hdfs Files To Hive Tables
        Tables Types
        Inner Tables
        External Tables
        Hive Working with unstructured data
        Hive Working With Xml Data
        Hive Working With Json Data
        Hive Working With Urls And Weblog Data
        Hive Unions
        Hive Joins
        Multi Table / File Inserts
        Inserting Into Local Files
        Inserting Into Hdfs Files
        Hive UDF (user defined functions)
        Hive UDAF (user defined Aggregated functions)
        Hive UDTF (user defined table Generated functions
        Partitioned Tables
        Non – Partitioned Tables
        Multi-column Partitioning
        Dynamic Partitions In Hive
        Performance Tuning mechanism
        Bucketing in hive
        Indexing in Hive
        Hive Examples
        Hive & Hbase Integration

    NOSQL

        What is “Not only SQL”
        NOSQL Advantages
        What is problem with RDBMS for Large
        Data Scaling Systems
        Types of NOSQL & Purposes
        Key Value Store
        Columer Store
        Document Store
        Graph Store
        Introduction to cassandra – NOSQL Database
        Introduction to MongoDB and CouchDB Database
        Intergration of NOSQL Databases with Hadoop

    HBASE

        Introduction to big table
        What is NOSQL and colummer store Database
        HBASE Introduction
        Hbase use cases
        Hbase basics
        Column families
        Scans
        Hbase Architecture
        Map Reduce Over Hbase
        Hbase data Modeling
        Hbase Schema design
        Hbase CRUD operators
        Hive & Hbaseinteragation
        Hbase storage handlers

    SPARK & SCALA

    SCALA PROGRAMMING

        Scala Basics
        Scala Data types
        Variable Declarations
        Val and var
        Type Casting
        REPL
        Scala Expressions

    SCALA CONTROL STRUCTURES

        if-else stmt
        match stmt
        while loop
        for loop

    SCALA COLLECTIONS

        List
        Array
        Tuple
        Map

    TRANSFORMATIONS OVER COLLECTION

        map()
        flatmap()
        Filter function
        Eliminating nulls and blankspaces
        Generating new Fields

    SCALA FUNCTIONS

        Functions Introduction
        Function used in map
        Functions used in filter
        Boolean function
        Various examples

    SPARK CORE

    INTRODUCTION OF SPARK

        Defining Spark
        Spark Features and Advatages.
        Spark Vs Tej
        Spark Vs Hana
        Spark VsMApReduce
        Spark Vs Pig
        Spark VsFlink

    RDD COMPUTATION

        Operations on a RDD
        Direct Acyclic Graph (DAG)
        RDD Actions and Transformations
        RDD computation
        Steps in RDD computation
        RDD persistence
        Persistence features

    PERSISTENCE Options:

        1) MEMORY_ONLY
        2) MEMORY_SER_ONLY
        3) DISK_ONLY
        4) DISK_SER_ONLY
        5) MEMORY_AND_DISK_ONLY

    SPARK CORE COMPUTING

        Fault Tolerence model in spark
        Different ways of creating a RDD
        Word Count Example
        Creating spark objects(RDDs) from Scala Objects(lists).
        Increasing the no of partitons
        Aggregations Over Structured Data:
        reduceByKey()

    GROUPINGS AND AGGREGATIONS

        i) Single Grouping and Single Aggregation
        ii) Single Grouping and multiple Aggregation
        iii) multi Grouping and Single Aggregation
        iv) Multi Grouping and Multi Aggregation
        Differences b/w reduceByKey() and groupByKey()
        Process of groupByKey
        Process of reduceByKey
        Reduce() function
        Various Transformations
        Various Built-in Functions

    Various Actions and Transformations:

        countByKey()
        countByValue()
        sortByKey()
        zip()
        Union()
        Distinct()
        Various count aggregation
        Joins
            inner join
            outer join
        Cartesian()
        Cogroup()
        Other actions and transformations
        Example programs

    SPARK SQL

        Introduction
        Making data Structured
        Case Classes
        ways to extract case class objects
            1) using function
            2) using map with multiple exressions
            3) using map with single expression
        Sql Context
        Data Frames API
        DataSets API
        RDD vs DataFramevsDataSet
        Working with sql statements
        Spark and Hive Integration
        Spark and mysql Integration
        Working with CSV
        Working with JSON

    DEPLOYMENT MODES

        Local Mode
        Cluster Modes(Standalone , YARN, Mesos)

    SPARK APLLICATION

        Stages and Tasks
        Driver and Executor

    SPARK SUBMISSION

        Sparksubmit creating jar using Eclipse IDE
        Simple Build Tool(SBT) for creating jar
        Intellij IDEA IDE to Launch spark Application
        Spark and Cassandra
