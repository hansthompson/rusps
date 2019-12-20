# rusps -   Validate And Standardize US Addresses 
Have you ever needed to do inner joins of addresses from different data sets? 
Hook into the USPS api using this package!  
### 
```
devtools::install_github("hansthompson/rusps")
library(rusps)
library(XML)
username <- 'XXXYYYYYZZZZ' # get this quickly and freely by signing up at https://registration.shippingapis.com/ (not commercial).
street1 <- '333 W raspberry road' # this is the street address
street2 <- '333  raspberry rd'
city   <- 'anchorage'
state  <- 'ak'

validate_address_usps(username = username, street = street1, city = city, state = state) # API also takes `zipcode` but it's optional

#  Address.Address2       Address.City      Address.State       Address.Zip5       Address.Zip4  Address..attrs.ID 
# "333 RASPBERRY RD"        "ANCHORAGE"               "AK"            "99518"             "1565"                "0" 

# Check if two diffent Addresses resolve to the same address
all(validate_address_usps(username, street1, city, state)  == validate_address_usps(username, street2, city, state))
# TRUE
```

More Documentation Here:
https://www.usps.com/business/web-tools-apis/address-information-api.htm#_Toc410982986


#### Some useful code snippets:
API returns multiple results often (example below). Attribute IDs aren't useful when trying to just get clean addresses. This code snippet will help you resolve above issues.

Before cleaning:
```
validate_address_usps(username = 'XXXXXXXXX', 
    street='333  raspberry rd', 
    city = 'anchorage', 
    state = 'ak')
#           Address2      City State  Zip5 Zip4 .attrs
#  333 RASPBERRY RD ANCHORAGE    AK 99518 1565      0
#                NA        NA    NA    NA   NA      0
#                NA        NA    NA    NA   NA      0
#                NA        NA    NA    NA   NA      0
#                NA        NA    NA    NA   NA      0
#  333 RASPBERRY RD ANCHORAGE    AK 99518 1565      0
#  333 RASPBERRY RD ANCHORAGE    AK 99518 1565      1
#  333 RASPBERRY RD ANCHORAGE    AK 99518 1565      2
#                NA        NA    NA    NA   NA      0
#                NA        NA    NA    NA   NA      0
#  333 RASPBERRY RD ANCHORAGE    AK 99518 1565      0
```

After cleaning:
```
library(tidyverse)
validate_address_usps(username = '582NA0003881', 
        street='333  raspberry rd', 
        city = 'anchorage', 
        state = 'ak') %>% 
    select(-`.attrs`)  %>% 
    filter(Address2 != 'NA')  %>% 
    unique()
#          Address2      City State  Zip5 Zip4
# 333 RASPBERRY RD ANCHORAGE    AK 99518 1565
```

Another thing to note is API errors out with the `#` symbol. so clean the street address before passing
```
street_raw <- '333  raspberry rd #2'
validate_address_usps(username = '582NA0003881', 
        street = gsub('#', '', street_raw), 
        city = 'anchorage', 
        state = 'ak')
```


