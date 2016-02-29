module ApplicationHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)", :class => 'btn btn-sm btn-danger')
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", :class => 'btn btn-sm btn-primary')
  end

  def current_url(new_params)
    options = params.dup
    options.merge!(new_params)
    string = options.map{ |k,v| "#{k}=#{v}" }.join("&")
    request.fullpath.split("?")[0] + "?" + string
  end

  def render_salt_log(message)
    if message["changes"].kind_of?(Hash)
      if message["changes"].has_key?("diff")
        content_tag("pre") do
          content_tag("code", class: "diff") do
            message["changes"]["diff"]
          end
        end
      elsif message["changes"].find { |k,v| v.kind_of?(Hash) && v.has_key?("diff") }
        message["changes"].collect do |file, file_changes|
          content_tag("div", file) +
          content_tag("pre") do
            content_tag("code", class: "diff") do
              file_changes["diff"]
            end
          end
        end.join().html_safe
      else
        content_tag("pre") do
          content_tag("code", class: "yaml") do
            message.to_yaml
          end
        end
      end
    else
      content_tag("pre") do
        if message["error"].kind_of? Array
          message["error"].join("\n")
        else
          message["error"]
        end
      end
    end
  end
end
