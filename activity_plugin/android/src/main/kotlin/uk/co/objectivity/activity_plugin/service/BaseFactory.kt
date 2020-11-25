package uk.co.objectivity.activity_plugin.service

abstract class BaseFactory {
    companion object {
        private val lock: Any = Object()
    }

    fun synchronized(method: () -> Unit) {
        synchronized(lock, method)
    }
}
