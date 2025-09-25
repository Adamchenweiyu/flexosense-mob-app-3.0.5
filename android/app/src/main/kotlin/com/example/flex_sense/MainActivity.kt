package com.example.flex_sense

import com.example.flex_sense.plugin.ble_state.BleStatePlugin
import com.example.flex_sense.plugin.device_core.event.DeviceCoreEventPlugin
import com.example.flex_sense.plugin.device_core.method.DeviceCoreMethodPlugin
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        flutterEngine.plugins.add(BleStatePlugin())
        flutterEngine.plugins.add(DeviceCoreMethodPlugin())
        flutterEngine.plugins.add(DeviceCoreEventPlugin())
    }
}
