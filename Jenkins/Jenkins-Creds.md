<details>
<summary>Markdown Keyboard shortcut</summary>
<br>
    1. Ctrl/Cmd + B	Toggle bold
    2. Ctrl/Cmd + I	Toggle italic
    3. Alt+S (on Windows)	Toggle strikethrough1
    4. Ctrl + Shift + ]	Toggle heading (uplevel)
    5. Ctrl + Shift + [	Toggle heading (downlevel)
    6. Ctrl/Cmd + M	Toggle math environment
    7. Alt + C	Check/Uncheck task list item
    8. Ctrl/Cmd + Shift + V	Toggle preview
    9. Ctrl/Cmd + K V	Toggle preview to side
</details>

<details>
<summary>Introuction</summary>
<br>

https://github.com/jenkinsci/credentials-plugin/blob/master/docs/user.adoc#rest-api

    While the above security recommendations are generally valid for any situation where Jenkins has access to high value credentials, because:

        the internal store is stored in the JENKINS_HOME

        the internal store is encrypted using a key that is also stored in JENKINS_HOME

        the JVM running Jenkins must have access to these files

    In order to understand how to manage credentials with the Credentials API plugin, you need to understand a number of Jenkins concepts:

        * Contexts within Jenkins

        * Authentication within Jenkins

        * The Jenkins security model

    each authorization strategy is provided with the :

        * Permission requested

        * Authentication requesting

        * Context of request

    Credentials types
    
    * Most people tend to think of there being only 5 or 6 types of credentials / secrets:

    * Password

    * Username and password

    * SSH private key

    * Public Certificate and private key

    * Binary blob data

    * That OAuth thingy

The Jenkins Administrator can configure which credentials types are actually permitted to be used in a Jenkins instance using the 

```
Jenkins › Manage Jenkins › Configure Credentials screen

```



</details>
