defmodule FriendsforeverWeb.PageController do
  use FriendsforeverWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def hello(conn, _params) do
    html(conn, "hello, world!")
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end
end
