/*
 * Copyright (C) 2019-2021 Jolla Ltd.
 * Copyright (C) 2019-2021 Slava Monich <slava@monich.com>
 *
 * You may use this file under the terms of the BSD license as follows:
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 *   1. Redistributions of source code must retain the above copyright
 *      notice, this list of conditions and the following disclaimer.
 *   2. Redistributions in binary form must reproduce the above copyright
 *      notice, this list of conditions and the following disclaimer in
 *      the documentation and/or other materials provided with the
 *      distribution.
 *   3. Neither the names of the copyright holders nor the names of its
 *      contributors may be used to endorse or promote products derived
 *      from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * The views and conclusions contained in the software and documentation
 * are those of the authors and should not be interpreted as representing
 * any official policies, either expressed or implied.
 */

#include "Util.h"

const QString Util::CARD_TYPE_KEY("cardType");
const QTimeZone Util::FINLAND_TIMEZONE("Europe/Helsinki");

guint32 Util::uint32le(const guint8* data)
{
    return (((guint32)data[3]) << 24) +
        (((guint32)data[2]) << 16) +
        (((guint32)data[1]) << 8) +
        data[0];
}

guint32 Util::uint32be(const guint8* data)
{
    return (((guint32)data[0]) << 24) +
        (((guint32)data[1]) << 16) +
        (((guint32)data[2]) << 8) +
        data[3];
}

guint16 Util::uint16le(const guint8* data)
{
    return (((guint16)data[1]) << 8) + data[0];
}

guint16 Util::uint16be(const guint8* data)
{
    return (((guint16)data[0]) << 8) + data[1];
}

QString Util::toHex(const QByteArray aData)
{
    static const char hex[] = "0123456789abcdef";
    const uchar* data = (uchar*)aData.constData();
    const int n = aData.size();
    QString str;
    str.reserve(2*n);
    for (int i = 0; i < n; i++) {
        const uchar b = data[i];
        str.append(QChar(hex[(b & 0xf0) >> 4]));
        str.append(QChar(hex[b & 0x0f]));
    }
    return str;
}
