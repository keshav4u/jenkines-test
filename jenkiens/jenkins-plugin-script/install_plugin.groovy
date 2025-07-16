import jenkins.model.*
import hudson.PluginWrapper

def plugins = [
    "github",
    "docker-build-publish",
    "workflow-aggregator",
    "nodejs",
    "pipeline-stage-view"
]

def instance = Jenkins.getInstance()
def pluginManager = instance.getPluginManager()
def updateCenter = instance.getUpdateCenter()

pluginManager.doCheckUpdatesServer()
def installed = false

plugins.each { pluginId ->
    if (!pluginManager.getPlugin(pluginId)) {
        println "Installing plugin: $pluginId"
        def plugin = updateCenter.getPlugin(pluginId)
        if (plugin) {
            plugin.deploy()
            installed = true
        } else {
            println "Plugin not found in Update Center: $pluginId"
        }
    } else {
        println "Plugin already installed: $pluginId"
    }
}

if (installed) {
    println "Plugins installed, initializing a restart..."
    Jenkins.instance.save()
    
}


Jenkins.instance.restart()