json.array!(@to_dos) do |to_do|
  json.extract! to_do, :id, :title, :notes, :due_date, :admin_id, :task_status
  json.url to_do_url(to_do, format: :json)
end
