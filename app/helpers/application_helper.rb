module ApplicationHelper
    ALERT_TYPES = [:danger, :info, :success, :warning]

    def bootstrap_flash
        flash_messages = []
        flash.each do |type, message|
            next if message.blank?

            type = :success if type == :notice
            type = :danger if type == :alert
            type = :info unless ALERT_TYPES.include?(type)

            Array(message).each do |msg|
                text = content_tag(:li, content_tag(:div,
                                                    content_tag(:button, raw("&times;"), :class => "close", "data-dismiss" => "alert") +
                                                    msg.html_safe, :class => "alert fade in alert-#{type}"))
                flash_messages << text if msg
            end
        end
        flash_messages.join("\n").html_safe
    end

    def markdown(text, source = nil)
      text ||= ''
        if source
            text.gsub!(/!\(meta:([a-zA-Z-]+)\)/) do |match|
                source.meta[$1] || "unknown"
            end
            text.gsub!(/!\(meta:(\w.+):(.+)\)/) do |match|
                source.meta[$1] || $2
            end
        end

        renderer = Redcarpet::Render::HTML.new(hard_wrap: true, filter_html: true)
        options = {
            autolink: true,
            no_intra_emphasis: true,
            fenced_code_blocks: true,
            lax_html_blocks: true,
            strikethrough: true,
            superscript: true
        }
        Redcarpet::Markdown.new(renderer, options).render(text).html_safe
    end
end
