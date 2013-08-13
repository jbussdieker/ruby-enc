module NodesHelper
  def node_report_time(time)
    if time
      time_ago_in_words(time) + " ago"
    else
      "unreported"
    end
  end

  def node_puppet_status(node)
    @client ||= Mcollective::Client.new
    @results ||= @client.run("puppetd", "status")
    result = @results.find {|r| r.sender == node.name}
    result
  end

  def node_status_badge(node)
    if node.status
      case node.status
        when "changed"
          content_tag(:span, node.status, :class => 'label label-success')
        when "unchanged"
          content_tag(:span, node.status, :class => 'label label-default')
        when "failed"
          content_tag(:span, node.status, :class => 'label label-danger')
      end
    else
      content_tag(:span, "unreported", :class => 'label label-default')
    end
  end
end
