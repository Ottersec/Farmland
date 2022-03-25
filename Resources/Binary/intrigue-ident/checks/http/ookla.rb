module Intrigue
module Ident
module Check
class Ookla < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["COTS"],
        vendor:"Ookla",
        product:"Speedtest Server",
        description: "page title",
        references: ["https://support.ookla.com/hc/en-us/articles/234578568-How-To-Install-Submit-Server"],
        match_logic: :all,
        matches: [
          {
            match_type: :content_body,
            match_content: /<title>OoklaServer/,
          }
        ],
        version: nil,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end

end
end
end
end
