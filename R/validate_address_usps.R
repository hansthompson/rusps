# validate addresses using usps

validate_address_usps <- function(username, street, city, state) {
  scheme_host_path <- "http://production.shippingapis.com/ShippingAPITest.dll?API=ZipCodeLookup&XML=<ZipCodeLookupRequest USERID=\""

  URL <- paste0(scheme_host_path, username ,
                "\"><Address ID=\"0\"><Address1></Address1><Address2>", street,
                '</Address2><City>', city, '</City><State>', state,
                '</State></Address></ZipCodeLookupRequest>')
  unlist(xmlToList(xmlParse(URL)))
}
