module TimeMachineHelper
  # expects sleep() to be called +cycles+ times, and then raises an Interrupt
  def hijack_sleep(cycles)
    results = [*1..cycles] # irrelevant truthy values for each sleep call expected
    Kernel::stubs(:sleep).returns(*results).then.raises(Interrupt)
  end
end

World(TimeMachineHelper)