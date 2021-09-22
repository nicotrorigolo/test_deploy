def nodelabel = "jenkins-k8sagent-${UUID.randomUUID().toString()}" //Creation du node "nodelabel"

podTemplate(
  label: nodelabel,
  namespace: "jenkins",
  serviceAccount: "jenkins",
  yaml: """
apiVersion: v1
kind: Pod
metadata:
  labels:
    component: ci
spec:
  containers:
    - name: python
      image: python:3.9
      command:
        - cat
      tty: true
    - name: kubectl
      image: tecpi/kubectl-helm
      command: ["cat"]
      tty: true
"""
) {
  node(nodelabel) {
      
    node("docker-agent") {
        stage("build") {
            git branch: 'main', url: 'https://github.com/nicotrorigolo/tp_fil_rouge.git'
            sh "sudo docker build -t registry.gitlab.com/nicorigolo/nicojenkins ."
            sh "sudo docker login registry.gitlab.com"
            sh "sudo docker push registry.gitlab.com/nicorigolo/nicojenkins"
        }
    }
    
    stage("Deploy") {
        container("kubectl") {
          git branch: 'main', url: 'https://github.com/nicotrorigolo/tp_fil_rouge.git'
          sh "kubectl apply -f k8s -n prod"
        }
    }
    
  }
}