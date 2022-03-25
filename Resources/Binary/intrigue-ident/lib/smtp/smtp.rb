module Intrigue
  module Ident
    module Smtp
      include Intrigue::Ident::SimpleSocket

      # gives us the recog smtp matchers
      include Intrigue::Ident::RecogWrapper::Smtp

      def generate_smtp_request_and_check(ip, port = 25, debug = false)

        # do the request (store as string and funky format bc of usage in core.. and  json conversions)
        banner_string = grab_banner_smtp(ip, port)
        details = {
          "details" => {
            "banner" => banner_string,
          },
        }

        results = []

        checks = []
        if Intrigue::Ident::Smtp::CheckFactory.checks != nil
          # generate the checks
          checks = Intrigue::Ident::Smtp::CheckFactory.checks.map {
            |x|
            x.new.generate_checks
          }.compact.flatten
        end
        # and run them against our result
        checks.each do |check|
          results << match_smtp_response_hash(check, details)
        end

        recog_results = []

        # Run recog across the banner
        if banner_string.split(" ")[1..-1]
          short_banner_string = banner_string.split(" ")[1..-1].join(" ").gsub("\r\n", "") # skip 220 and hostname
          recog_results << recog_match_smtp_banner(short_banner_string)
        end

        # Run recog across the banner (also removing the hostname
        if banner_string.split(" ")[2..-1]
          short_banner_string = banner_string.split(" ")[2..-1].join(" ").gsub("\r\n", "") # skip 220 and hostname
          recog_results << recog_match_smtp_banner(short_banner_string)
        end

        { "fingerprint" => (results + recog_results.flatten).uniq.compact, "banner" => banner_string }
      end

      private

      def grab_banner_smtp(ip, port, timeout = 60)
        begin
          if socket = connect_tcp(ip, port, timeout)
            #socket.writepartial("HELO friend.local\r\n\r\n")
            out = socket.readpartial(24576, timeout: timeout)
          else
            out = nil
          end
        rescue Errno::EHOSTUNREACH => e
          puts "Error while reading! Reset."
          out = nil
        rescue Errno::ECONNRESET => e
          puts "Error while reading! Reset."
          out = nil
        rescue Socketry::TimeoutError
          puts "Error while reading! Timeout."
          out = nil
        end

        "#{out}".encode("UTF-8", invalid: :replace, undef: :replace, replace: "?")
      end
    end
  end
end
