package com.example.biometric_app



import android.widget.Toast
import androidx.biometric.BiometricManager
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import java.util.concurrent.Executor



class MainActivity : FlutterFragmentActivity() {
    private lateinit var executor: Executor
    private lateinit var biometricPrompt: BiometricPrompt
    private lateinit var biometricManager: BiometricManager
    private lateinit var promptInfo: BiometricPrompt.PromptInfo
    private val BIOMETRIC_CHANNEL = "auth_app.com/biometric"
    private lateinit var channel: MethodChannel


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, BIOMETRIC_CHANNEL)

        channel.setMethodCallHandler { call, result ->

            if (call.method == "showBiomtericLogin") {
                showBiomtericLogin(result)
            }


        }
    }

    private fun showBiomtericLogin(methodChannelResult:MethodChannel.Result) {
        executor = ContextCompat.getMainExecutor(this)

        biometricPrompt = androidx.biometric.BiometricPrompt(this as FlutterFragmentActivity, executor,
                object : BiometricPrompt.AuthenticationCallback() {
                    override fun onAuthenticationError(errorCode: Int,
                                                       errString: CharSequence) {
                        super.onAuthenticationError(errorCode, errString)
                        Toast.makeText(applicationContext,
                                "Authentication error: $errString", Toast.LENGTH_SHORT)
                                .show()
                        methodChannelResult.success(false)

                    }

                    override fun onAuthenticationSucceeded(
                            result: BiometricPrompt.AuthenticationResult) {
                        super.onAuthenticationSucceeded(result)

                        Toast.makeText(applicationContext,
                                "Authentication succeeded!", Toast.LENGTH_SHORT)
                                .show()

                        methodChannelResult.success(true)
                    }

                    override fun onAuthenticationFailed() {
                        super.onAuthenticationFailed()
                        Toast.makeText(applicationContext, "Authentication failed",
                                Toast.LENGTH_SHORT)
                                .show()
                        methodChannelResult.success(false)

                    }

                })

        promptInfo = BiometricPrompt.PromptInfo.Builder()
                .setTitle("Biometric login for my app")
                .setSubtitle("Log in using your biometric credential")
                .setDeviceCredentialAllowed(true)
                .build()


        biometricPrompt.authenticate(promptInfo)

    }

}

