<details>
<summary>Introuction</summary>
<br>
    While the above security recommendations are generally valid for any situation where Jenkins has access to high value credentials, because:

    the internal store is stored in the JENKINS_HOME

    the internal store is encrypted using a key that is also stored in JENKINS_HOME

    the JVM running Jenkins must have access to these files
</details>
