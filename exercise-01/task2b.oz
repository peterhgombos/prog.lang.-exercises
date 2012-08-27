declare
X Y
X = 'dette er magisk'
{Browse Y} % Browse runs in a separate thread, and reading unbound dataflow variables will cause the thread to wait until the value is bound
Y = X