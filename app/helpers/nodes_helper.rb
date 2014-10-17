module NodesHelper
  def node_report_time(time)
    if time
      time_ago_in_words(time) + " ago"
    else
      "unreported"
    end
  end

  def puppet_agent_node_status(node)
    status = @puppet_agent.node_status(node.name)
    if status
      case status
        when "idling"
          css = 'default'
        when "running"
          css = 'success'
        when "disabled"
          css = 'danger'
        else
          css = 'default'
      end

      content_tag(:div, class: 'btn-group') do
        content_tag(:button, type: :button, class: "btn btn-#{css} btn-sm dropdown-toggle", 'data-toggle' => :dropdown) do
          status.capitalize.html_safe + " " + tag(:span, class: :caret)
        end +
        content_tag(:ul, class: 'dropdown-menu', role: 'menu') do
          if status == "disabled"
            content_tag(:li, link_to("Enable", enable_node_path(node))) +
            content_tag(:li, link_to("Run Once", runonce_node_path(node)))
          elsif status == "idling"
            content_tag(:li, link_to("Disable", disable_node_path(node))) +
            content_tag(:li, link_to("Run Once", runonce_node_path(node)))
          end
        end
      end
    end
  end

  def puppet_agent_status(node)
    status = @puppet_agent.status[node.name]

    if status
      case status
        when "idling"
          css = 'default'
        when "running"
          css = 'success'
        when "disabled"
          css = 'danger'
        else
          css = 'default'
      end

      content_tag(:div, class: 'btn-group') do
        content_tag(:button, type: :button, class: "btn btn-#{css} btn-xs dropdown-toggle", 'data-toggle' => :dropdown) do
          status.capitalize.html_safe + " " + tag(:span, class: :caret)
        end +
        content_tag(:ul, class: 'dropdown-menu', role: 'menu') do
          if status == "disabled"
            content_tag(:li, link_to("Enable", enable_node_path(node))) +
            content_tag(:li, link_to("Run Once", runonce_node_path(node)))
          elsif status == "idling"
            content_tag(:li, link_to("Disable", disable_node_path(node))) +
            content_tag(:li, link_to("Run Once", runonce_node_path(node)))
          end
        end
      end
    end
  end

  def puppet_agent_status_old(node)
    status = @puppet_agent.status[node.name]

    case status
      when "idling"
        content_tag(:span, status, :class => 'label label-default')
      when "running"
        content_tag(:span, status, :class => 'label label-success')
      when "disabled"
        content_tag(:span, status, :class => 'label label-warning')
      else
        content_tag(:span, "offline", :class => 'label label-danger')
    end
  end

  def node_status_badge(node)
    if node.status
      case node.status
        when "changed"
          content_tag(:span, node.status, :class => 'label label-info')
        when "pending"
          content_tag(:span, node.status, :class => 'label label-warning')
        when "unchanged"
          content_tag(:span, node.status, :class => 'label label-success')
        when "failed"
          content_tag(:span, node.status, :class => 'label label-danger')
      end
    else
      content_tag(:span, "unreported", :class => 'label label-default')
    end
  end
end
