json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :title, :description, :status, :solution
  json.url ticket_url(ticket, format: :json)
end
