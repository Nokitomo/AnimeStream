package io.flutter.plugins

import androidx.annotation.Keep
import io.flutter.Log
import io.flutter.embedding.engine.FlutterEngine
import it.aesys.flutter_video_cast.FlutterVideoCastPlugin

@Keep
object GeneratedPluginRegistrant {
    private const val TAG = "GeneratedPluginRegistrant"
    fun registerWith(flutterEngine: FlutterEngine) {
        try {
            flutterEngine.plugins.add(FlutterVideoCastPlugin())
        } catch (e: Exception) {
            Log.e(
                TAG,
                "Error registering plugin flutter_video_cast, it.aesys.flutter_video_cast.FlutterVideoCastPlugin",
                e
            )
        }
    }
}