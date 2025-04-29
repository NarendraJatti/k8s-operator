// Simplified example
func main() {
    // Watch for CronTab events
    informer := watchFor("crontabs.stable.example.com")
    
    for event := range informer {
        cronTab := event.Object
        // Create real CronJob based on cronTab.Spec
        createK8sCronJob(cronTab.Spec.cronSpec, cronTab.Spec.image)
    }
}


# Using Operator SDK
operator-sdk init --domain example.com --repo github.com/example/crontab-operator
operator-sdk create api --group stable --version v1 --kind CronTab

or 
==
kubebuilder init --domain example.com
kubebuilder create api --group stable --version v1 --kind CronTab