# SecureUserDefaults
<u>It's simple replacement your current syntax :> 'UserDefaults' to 'SecureUserDefaults'</u>

**Usage**

<p>To Store value 

<code>SecureUserDefaults.standard.setValue("Value", forKey: "Key")
SecureUserDefaults.standard.syncronize()</code></p>

<p>Retrive Value 

<code>let value = SecureUserDefaults.standard.value(forKey: "Key") as? String</code></p>

<p>Reset Defaults 

<code>SecureUserDefaults.standard.resetSecureUserDefaults()</code></p>

<p> Enjoy :) </p>
