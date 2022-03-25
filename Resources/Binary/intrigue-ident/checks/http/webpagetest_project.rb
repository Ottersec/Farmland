module Intrigue
module Ident
module Check
class WebpagetestProject < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["COTS"],
        vendor:"Webpagetest Project",
        product:"Webpagetest",
        description: "title",
        references: [
          "https://blog.assetnote.io/bug-bounty/2019/03/19/rce-on-mozilla-zero-day-webpagetest/"
        ],
        match_logic: :all,
        matches: [
          {
            match_type: :content_title,
            match_content: /WebPageTest - Website Performance and Optimization Test/i,
          }
        ],
        version: nil,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }
    ]
  end

end
end
end
end
