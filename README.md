# rusps -   Validate And Standardize US Addresses 
Have you ever needed to do inner joins of addresses from different data sets? 
Hook into the USPS api using this package!  
### 
```
devtools::install_github("hansthompson/rusps")
library(rusps)
library(XML)
username <- 'XXXYYYYYZZZZ' # get this quickly and freely by signing up at https://registration.shippingapis.com/ (not commercial).
street1 <- '333 W raspberry road'
street2 <- '333  raspberry rd'
city   <- 'anchorage'
state  <- 'ak'

validate_address_usps(username, street, city, state)

#  Address.Address2       Address.City      Address.State       Address.Zip5       Address.Zip4  Address..attrs.ID 
# "333 RASPBERRY RD"        "ANCHORAGE"               "AK"            "99518"             "1565"                "0" 

# Check if two diffent Addresses resolve to the same address
all(validate_address_usps(username, street, city, state)  == validate_address_usps(username, street, city, state))
# TRUE
```

More Documentation Here:
https://www.usps.com/business/web-tools-apis/address-information-api.htm#_Toc410982986
