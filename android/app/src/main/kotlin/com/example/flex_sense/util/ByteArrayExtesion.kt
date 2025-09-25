package com.example.flex_sense.util

fun ByteArray.toHexString(): String {
    return joinToString(prefix = "[", postfix = "]") {
        String.format("%02X", it)
    }
}