# SecureUserDefaults
<p>
<u><i>It's simple replacement your current syntax :> 'UserDefaults' to 'SecureUserDefaults'</i></u>
</p>

<b>Usage</b>

<p>To Store value

<code>SecureUserDefaults.standard.setValue("Value", forKey: "Key")</code></p>
<p><code>SecureUserDefaults.standard.syncronize()</code></p>

<p>Retrive Value

<code>let value = SecureUserDefaults.standard.value(forKey: "Key") as? String</code></p>

<p>Reset Defaults

<code>SecureUserDefaults.standard.resetSecureUserDefaults()</code></p>

<p> Enjoy :) </p>
