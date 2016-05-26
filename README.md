# rusps -   Validate And Standardize US Addresses 
Have you ever needed to do inner joins of addresses from different data sets? 
Hook into the USPS api using this package!  
### 
```
devtools::install_github("hansthompson/rusps")
library(rusps)
library(XML)
username <- 'XXXYYYYYZZZZ' # get this at quickly by signing up at https://registration.shippingapis.com/
street1 <- '333 W raspberry road'
street2 <- '333  raspberry rd'
city   <- 'anchorage'
state  <- 'ak'

all(validate_address_usps(username, street1, city, state)  == validate_address_usps(username, street2, city, state))
```