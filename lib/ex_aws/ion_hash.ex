defmodule ExAws.IonHash do
  defp default_instance() do
    path =
      [:code.priv_dir(:ex_aws_qldb), "python"]
      |> Path.join()

    ExAws.ExPython.python_instance(to_charlist(path))
  end

  defp call_python(module, function, args) do
    pid = default_instance()
    return = ExAws.ExPython.call_python(pid, module, function, args)
    ExAws.ExPython.stop(pid)
    return
  end

  def get_digest(tx_id, statement, parameters) do
    call_python(:qldb_ionhash, :get_digest, [tx_id, statement, parameters])
  end
end
