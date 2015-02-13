module Admin::SubjectsHelper
  def add_task_button(f, tasks)
    new_object = f.object.class.reflect_on_association(tasks).klass.new

    fields = f.fields_for(tasks, new_object) do |builder|
      render "task_fields", f: builder
    end

    link_to("Add Task", "javascript:void(0);",
      onclick: h("add_fields(this, \"#{escape_javascript(fields)}\")"))
  end
end
