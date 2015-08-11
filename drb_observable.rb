module DRbObservable

  def add_observer(observer)
    raise(NameError, "observer must respond to 'update'") unless observer.respond_to?(:update)

    @observers ||= []
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer) if @observers
  end

  def notify_observers(*args)
    return unless @observers

    @observers.each { |o| o.update(*args) rescue delete_observer(o) }
  end
end
