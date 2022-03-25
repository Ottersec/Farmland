module Intrigue
  module Ident
    module FtpCheck
      class Vsftp < Intrigue::Ident::FtpCheck::Base
        def generate_checks
          [
            {
              type: 'fingerprint',
              category: 'application',
              tags: ['FTP Server'],
              vendor: 'vsFTPd',
              product: 'vsFTPd',
              references: [],
              version: nil,
              match_type: :content_banner,
              match_content: /\(vsFTPd\s[\d.]+\)/i,
              dynamic_version: ->(x) { _first_banner_capture(x, /\(vsFTPd\s([\d.]+)\)/i) },
              description: 'banner',
              hide: false,
              inference: true
            }
          ]
        end
      end
    end
  end
end
