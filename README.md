# Architecture as Code Demo

Demo of the Architecture as Code concept built with [Structurizr](https://structurizr.com/).

Read more at: [DevSecOps Notes](https://devsecopsnotes.substack.com/p/gitops-for-architecture)

To see the diagrams, copy the content of [workspace.dsl](workspace.dsl) into [playground.structurizr.com](https://playground.structurizr.com/)

You can also run Structurizr locally using the following command:

`docker run -it --rm -p 8080:8080 -e STRUCTURIZR_THEMES=//usr/local/structurizr-themes -v $(pwd):/usr/local/structurizr structurizr/structurizr local`

Or if you are using Git Bash on Windows:

`docker run -it --rm -p 8080:8080 -e STRUCTURIZR_THEMES=//usr/local/structurizr-themes -v //$(pwd):/usr/local/structurizr structurizr/structurizr local`
