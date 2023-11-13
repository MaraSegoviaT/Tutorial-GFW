install.packages("devtools")
install.packages("usethis")
library(devtools)
library(usethis)
#Instalar gfwr del repositorio de GitHub
devtools::install_github("GlobalFishingWatch/gfwr")

#Load package
library(gfwr)

#MI TOKEN GFW
# eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6ImtpZEtleSJ9.eyJkYXRhIjp7Im5hbWUiOiJGaXNoaW5nIEVmZm9ydCBpbiBDw61lcyBJc2xhbmRzIHByb3RlY3RlZCBhcmVhcyAiLCJ1c2VySWQiOjI4Mzc2LCJhcHBsaWNhdGlvbk5hbWUiOiJGaXNoaW5nIEVmZm9ydCBpbiBDw61lcyBJc2xhbmRzIHByb3RlY3RlZCBhcmVhcyAiLCJpZCI6OTk3LCJ0eXBlIjoidXNlci1hcHBsaWNhdGlvbiJ9LCJpYXQiOjE2OTY3Nzg5MzgsImV4cCI6MjAxMjEzODkzOCwiYXVkIjoiZ2Z3IiwiaXNzIjoiZ2Z3In0.hwcqVHvbN3qQcwl8QGPtQ99ybYW5UTALOjMzpHqiSdPgJ-Y4Uv_Tke52vyqMTskj6dMF34dkICCF3BrvEkpc0tO65wp4goEJZzAvTPZKT2VmsQsWDMLNEdvc956dtDhmwmrvx2tf4sfs8B_wUgOwdLkCo7KqTSicUgj6tDva4FLuuM7Od06pur36fuOff6fb54H-V8VD1P_Kg3BcrtouUzI1f6tC_FV5tMTw0q8VHLXG6TVe5zdvICZ_Rq9oGsDCvnxOMF8Kq9im3_NRWG8KdxFoeHAFcb-g421lNc8ur-jskv4sLlXIPgWV6P6XmZaZ2AczVFFuJRLWt9CL9U3-M0l_x7SRZwglIq0BczOjc01VTdWJgDF0cn3DpWMHL4c9J06yP0MFtXuwrpoQmBepavqn5X_rN7dwtiq-8u__w8ApulUXhRYu-F1CqsJ-XpV1xLXYDs6e3DFWg7U2AShs1JWQoszvXF4rKrdpwAFPJgvYdXfN6QZjyvYvMeNiwsnj
#Meter token aqui como GFW_TOKEN = "PASTE_YOUR_TOKEN_HERE"
usethis::edit_r_environ()

# Save Crtl+S ".Renvrion" tab and then restart R session Ctrl + Shift + F10

#Coger la llave como objeto desde el R enviroment
key <- gfw_auth()

library(gfwr)

library(usethis)
git_sitrep()

usethis::create_github_token()
#  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
gitcreds::gitcreds_set()

gh_token_help()
create_github_token()


# load the key as object directly from the R environment

# library(gfwr)
key <- gfw_auth()
# or
key <- Sys.getenv("GFW_TOKEN")