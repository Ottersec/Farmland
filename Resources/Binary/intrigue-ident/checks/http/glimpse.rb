module Intrigue
module Ident
module Check
class Glimpse < Intrigue::Ident::Check::Base
  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["Web Framework"],
        vendor: "Glimpse",
        product: "Glimpse",
        description: "glimpse.axd version",
        version: nil,
        references: [
          "https://docs.microsoft.com/en-us/aspnet/mvc/overview/performance/profile-and-debug-your-aspnet-mvc-app-with-glimpse"
        ],
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /Glimpse - Configuration Page/,
          }
        ],
        dynamic_version: lambda { |x| 
          _first_body_capture(x,/name="glimpseRuntimeVersion" value="([\d\.]*)"/) 
        },
        paths: [{ path: "#{url}/glimpse.axd", follow_redirects: true } ],
        require_product: "ASP.NET",
        inference: true
      }
    ]
  end
end
end
end
end
