module Intrigue
module Ident
module Check
class Axway < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["COTS"],
        vendor: "Axway",
        product: "SecureTransport",
        website: "https://www.axway.com/en/products/secure-transport",
        references: [
          "https://www-356.ibm.com/partnerworld/gsd/solutiondetails.do?&solution=47052"
        ],
        version: nil,
        match_logic: :all,
        matches: [
          {
            match_type: :content_headers,
            match_content:  /server: SecureTransport/i,
          }
        ],
        dynamic_version: lambda {|x| _first_header_capture(x,/SecureTransport (.*) build:.*/)},
        dynamic_update: lambda {|x| _first_header_capture(x,/SecureTransport\ .*\ build:(.*)$/)},
        description:"server header - build is avail too",
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end
  
end
end
end
end
