(() => {
'use strict';

// ─── Color helpers ─────────────────────────────────────────────

const C = (r, g, b, a = 1) => ({ r, g, b, a });
const css = (c) => `rgba(${(c.r * 255) | 0},${(c.g * 255) | 0},${(c.b * 255) | 0},${c.a})`;
const withAlpha = (c, a) => ({ ...c, a });
const gray = (v, a = 1) => C(v, v, v, a);
const luma = (c) => c.r * 0.299 + c.g * 0.587 + c.b * 0.114;

// ─── Theme definitions ─────────────────────────────────────────

const THEME_ORDER = [
    'white', 'turquoise', 'glacier', 'ocean', 'tennis', 'signalBlue', 'salmon', 'yellow',
    'beige', 'pistachio', 'lavender', 'rose', 'skyBlue', 'cream', 'slate', 'noir'
];

const THEMES = {
    white:      { bg: C(1.0, 1.0, 1.0),       tick: gray(0.15),                 num: gray(0.15),                 hand: gray(0.98), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    turquoise:  { bg: C(0.69, 0.89, 0.89),    tick: C(0.08, 0.24, 0.28),       num: C(0.08, 0.24, 0.28),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    glacier:    { bg: C(0.659, 0.718, 0.749),  tick: C(0.12, 0.16, 0.20, 0.8), num: C(0.12, 0.16, 0.20),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    ocean:      { bg: C(0.055, 0.125, 0.271),  tick: C(0.50, 0.88, 0.80, 0.7), num: C(0.50, 0.88, 0.80, 0.9),  hand: gray(0.93), shadow: gray(0, 0.4),  dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    tennis:     { bg: C(0.0, 0.451, 0.263),    tick: C(0.45, 0.72, 0.35, 0.7), num: C(0.75, 0.86, 0.12),       hand: gray(0.93), shadow: gray(0, 0.35), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    signalBlue: { bg: C(0.0, 0.624, 0.851),    tick: gray(1.0, 0.65),           num: gray(1.0, 0.85),           hand: gray(0.93), shadow: gray(0, 0.3),  dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    salmon:     { bg: C(0.890, 0.694, 0.561),  tick: C(0.28, 0.13, 0.08, 0.8), num: C(0.28, 0.13, 0.08),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    yellow:     { bg: C(0.949, 0.745, 0.0),    tick: C(0.30, 0.16, 0.0, 0.85), num: C(0.30, 0.16, 0.0),        hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    beige:      { bg: C(0.878, 0.808, 0.624),  tick: C(0.25, 0.18, 0.08, 0.8), num: C(0.25, 0.18, 0.08),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    pistachio:  { bg: C(0.714, 0.769, 0.639),  tick: C(0.14, 0.20, 0.10, 0.8), num: C(0.14, 0.20, 0.10),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    lavender:   { bg: C(0.765, 0.788, 0.898),  tick: C(0.12, 0.12, 0.28, 0.8), num: C(0.12, 0.12, 0.28),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    rose:       { bg: C(0.898, 0.757, 0.796),  tick: C(0.28, 0.08, 0.12, 0.8), num: C(0.28, 0.08, 0.12),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    skyBlue:    { bg: C(0.733, 0.851, 0.941),  tick: C(0.22, 0.32, 0.50, 0.7), num: C(0.12, 0.20, 0.38),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    cream:      { bg: C(0.859, 0.851, 0.827),  tick: C(0.20, 0.18, 0.14, 0.8), num: C(0.20, 0.18, 0.14),       hand: gray(0.91), shadow: gray(0, 0.15), dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    slate:      { bg: C(0.275, 0.278, 0.290),  tick: gray(0.75, 0.6),           num: gray(0.85),                 hand: gray(0.93), shadow: gray(0, 0.4),  dot: gray(0.75), sec: C(0.80, 0.12, 0.12) },
    noir:       { bg: C(0.055, 0.055, 0.059),  tick: gray(0.70, 0.6),           num: gray(0.85),                 hand: gray(0.93), shadow: gray(0, 0.5),  dot: gray(0.75), sec: C(0.80, 0.12, 0.12) }
};

// ─── Lume colors ───────────────────────────────────────────────

const LUME_ORDER = [
    'red', 'amber', 'lavender', 'pink', 'sage', 'skyBlue', 'cyan',
    'peach', 'green', 'teal', 'yellow', 'mint', 'iceCyan', 'white'
];

const LUME_COLORS = {
    red:      C(0.988, 0.012, 0.012),
    amber:    C(1.0, 0.533, 0.0),
    lavender: C(0.671, 0.635, 0.976),
    pink:     C(1.0, 0.596, 0.714),
    sage:     C(0.541, 0.796, 0.71),
    skyBlue:  C(0.443, 0.847, 0.973),
    cyan:     C(0.004, 0.906, 1.0),
    peach:    C(1.0, 0.8, 0.604),
    green:    C(0.122, 0.98, 0.098),
    teal:     C(0.0, 0.98, 0.765),
    yellow:   C(0.996, 0.875, 0.267),
    mint:     C(0.588, 1.0, 0.655),
    iceCyan:  C(0.451, 1.0, 1.0),
    white:    C(0.957, 0.957, 0.957)
};

// ─── Cities ────────────────────────────────────────────────────

const CITIES = [
    { name: 'Kyiv',         lat: 50.4501,  lon: 30.5234,   tz: 'Europe/Kyiv' },
    { name: 'Lviv',         lat: 49.8397,  lon: 24.0297,   tz: 'Europe/Kyiv' },
    { name: 'London',       lat: 51.5074,  lon: -0.1278,   tz: 'Europe/London' },
    { name: 'New York',     lat: 40.7128,  lon: -74.0060,  tz: 'America/New_York' },
    { name: 'Los Angeles',  lat: 34.0522,  lon: -118.2437, tz: 'America/Los_Angeles' },
    { name: 'Paris',        lat: 48.8566,  lon: 2.3522,    tz: 'Europe/Paris' },
    { name: 'Berlin',       lat: 52.5200,  lon: 13.4050,   tz: 'Europe/Berlin' },
    { name: 'Tokyo',        lat: 35.6762,  lon: 139.6503,  tz: 'Asia/Tokyo' },
    { name: 'Dubai',        lat: 25.2048,  lon: 55.2708,   tz: 'Asia/Dubai' },
    { name: 'Istanbul',     lat: 41.0082,  lon: 28.9784,   tz: 'Europe/Istanbul' },
    { name: 'Bangkok',      lat: 13.7563,  lon: 100.5018,  tz: 'Asia/Bangkok' },
    { name: 'Singapore',    lat: 1.3521,   lon: 103.8198,  tz: 'Asia/Singapore' },
    { name: 'Sydney',       lat: -33.8688, lon: 151.2093,  tz: 'Australia/Sydney' },
    { name: 'Toronto',      lat: 43.6532,  lon: -79.3832,  tz: 'America/Toronto' },
    { name: 'Barcelona',    lat: 41.3874,  lon: 2.1686,    tz: 'Europe/Madrid' },
    { name: 'Rome',         lat: 41.9028,  lon: 12.4964,   tz: 'Europe/Rome' },
    { name: 'Beijing',      lat: 39.9042,  lon: 116.4074,  tz: 'Asia/Shanghai' },
    { name: 'Seoul',        lat: 37.5665,  lon: 126.9780,  tz: 'Asia/Seoul' },
    { name: 'Tel Aviv',     lat: 32.0853,  lon: 34.7818,   tz: 'Asia/Tel_Aviv' },
    { name: 'Buenos Aires', lat: -34.6037, lon: -58.3816,  tz: 'America/Argentina/Buenos_Aires' }
];

// ─── Settings (localStorage) ───────────────────────────────────

const settings = {
    get theme()     { return localStorage.getItem('cf-theme') || 'turquoise'; },
    set theme(v)    { localStorage.setItem('cf-theme', v); },
    get movement()  { return localStorage.getItem('cf-mvmt') || 'digital'; },
    set movement(v) { localStorage.setItem('cf-mvmt', v); },
    get nightMode() { return localStorage.getItem('cf-night') || 'night'; },
    set nightMode(v){ localStorage.setItem('cf-night', v); },
    get lumeColor() { return localStorage.getItem('cf-lume') || 'cyan'; },
    set lumeColor(v){ localStorage.setItem('cf-lume', v); },
    get glowIntensity() {
        const v = localStorage.getItem('cf-glow');
        return v !== null ? parseFloat(v) : 0.7;
    },
    set glowIntensity(v) { localStorage.setItem('cf-glow', String(v)); },
    get city()      { return localStorage.getItem('cf-city') || 'Kyiv'; },
    set city(v)     { localStorage.setItem('cf-city', v); },
    get showDate() {
        const v = localStorage.getItem('cf-date');
        return v !== null ? v === 'true' : true;
    },
    set showDate(v) { localStorage.setItem('cf-date', String(v)); },
    get showTemp() {
        const v = localStorage.getItem('cf-temp');
        return v !== null ? v === 'true' : true;
    },
    set showTemp(v) { localStorage.setItem('cf-temp', String(v)); }
};

// ─── Solar calculation (NOAA simplified) ───────────────────────

const getDayOfYear = () => {
    const now = new Date();
    const start = new Date(now.getFullYear(), 0, 0);
    return Math.floor((now - start) / 86400000);
};

const getTzOffsetHours = (tz) => {
    const now = new Date();
    const utc = new Date(now.toLocaleString('en-US', { timeZone: 'UTC' }));
    const local = new Date(now.toLocaleString('en-US', { timeZone: tz }));
    return (local - utc) / 3600000;
};

const solarTimes = (lat, lon, tz) => {
    const doy = getDayOfYear();
    const gamma = 2 * Math.PI / 365 * (doy - 1);

    const eqTime = 229.18 * (0.000075
        + 0.001868 * Math.cos(gamma)
        - 0.032077 * Math.sin(gamma)
        - 0.014615 * Math.cos(2 * gamma)
        - 0.040849 * Math.sin(2 * gamma));

    const decl = 0.006918
        - 0.399912 * Math.cos(gamma)
        + 0.070257 * Math.sin(gamma)
        - 0.006758 * Math.cos(2 * gamma)
        + 0.000907 * Math.sin(2 * gamma)
        - 0.002697 * Math.cos(3 * gamma)
        + 0.00148  * Math.sin(3 * gamma);

    const latRad = lat * Math.PI / 180;
    const cosHA = Math.cos(90.833 * Math.PI / 180) / (Math.cos(latRad) * Math.cos(decl))
              - Math.tan(latRad) * Math.tan(decl);

    if (cosHA < -1 || cosHA > 1) return { sunrise: 6, sunset: 22 };

    const ha = Math.acos(cosHA) * 180 / Math.PI;
    const tzOff = getTzOffsetHours(tz);

    return {
        sunrise: (720 - 4 * (lon + ha) - eqTime) / 60 + tzOff,
        sunset:  (720 - 4 * (lon - ha) - eqTime) / 60 + tzOff
    };
};

const getHourInTz = (tz) => {
    const parts = new Intl.DateTimeFormat('en-US', {
        hour: 'numeric', minute: 'numeric', hour12: false, timeZone: tz
    }).formatToParts(new Date());
    let h = 0, m = 0;
    for (const p of parts) {
        if (p.type === 'hour') h = parseInt(p.value, 10);
        if (p.type === 'minute') m = parseInt(p.value, 10);
    }
    return h + m / 60;
};

const resolveNightMode = () => {
    const mode = settings.nightMode;
    if (mode === 'day') return false;
    if (mode === 'night') return true;
    const city = CITIES.find(c => c.name === settings.city);
    if (!city) return false;
    const times = solarTimes(city.lat, city.lon, city.tz);
    const hour = getHourInTz(city.tz);
    return hour < times.sunrise || hour >= times.sunset;
};

// ─── Weather ───────────────────────────────────────────────────

const weather = { temp: null, city: null, lastFetch: 0, fetching: false };

const fetchWeather = () => {
    if (weather.fetching) return;
    if (Date.now() - weather.lastFetch < 30 * 60 * 1000) return;

    const city = CITIES.find(c => c.name === settings.city);
    if (!city) return;

    weather.fetching = true;
    weather.city = city.name;

    fetch(`https://api.open-meteo.com/v1/forecast?latitude=${city.lat}&longitude=${city.lon}&current=temperature_2m`)
        .then(r => r.json())
        .then(data => {
            if (data.current?.temperature_2m !== undefined) {
                weather.temp = `${Math.round(data.current.temperature_2m)}\u00B0`;
                weather.lastFetch = Date.now();
            }
        })
        .catch(() => {})
        .finally(() => { weather.fetching = false; });
};

// ─── Canvas state ──────────────────────────────────────────────

let canvas, ctx;
let nightMode = false;
let theme, lumeCol, glow;
const FONT = '"Futura", "Jost", "Century Gothic", sans-serif';

// ─── Geometry helper ───────────────────────────────────────────

const polar = (cx, cy, angle, r) => {
    const a = angle - Math.PI / 2;
    return { x: cx + Math.cos(a) * r, y: cy + Math.sin(a) * r };
};

const roundRectPath = (x, y, w, h, r) => {
    ctx.beginPath();
    ctx.moveTo(x + r, y);
    ctx.lineTo(x + w - r, y);
    ctx.quadraticCurveTo(x + w, y, x + w, y + r);
    ctx.lineTo(x + w, y + h - r);
    ctx.quadraticCurveTo(x + w, y + h, x + w - r, y + h);
    ctx.lineTo(x + r, y + h);
    ctx.quadraticCurveTo(x, y + h, x, y + h - r);
    ctx.lineTo(x, y + r);
    ctx.quadraticCurveTo(x, y, x + r, y);
    ctx.closePath();
};

// ─── Drawing functions ─────────────────────────────────────────

const drawMinuteTicks = (cx, cy, R) => {
    for (let i = 0; i < 60; i++) {
        if (i % 5 === 0) continue;
        const angle = (i / 60) * Math.PI * 2;
        const inner = polar(cx, cy, angle, R * 0.88);
        const outer = polar(cx, cy, angle, R * 0.92);

        ctx.strokeStyle = css(nightMode ? withAlpha(lumeCol, 0.2) : theme.tick);
        ctx.lineWidth = R * 0.012;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(inner.x, inner.y);
        ctx.lineTo(outer.x, outer.y);
        ctx.stroke();
    }
};

const drawHourCapsules = (cx, cy, R) => {
    const w = R * 0.04;

    for (let i = 0; i < 12; i++) {
        const angle = (i / 12) * Math.PI * 2;
        const inner = polar(cx, cy, angle, R * 0.78);
        const outer = polar(cx, cy, angle, R * 0.92);

        if (nightMode) {
            ctx.strokeStyle = css(gray(0.12, 0.6));
            ctx.lineWidth = w;
            ctx.lineCap = 'round';
            ctx.beginPath();
            ctx.moveTo(inner.x, inner.y);
            ctx.lineTo(outer.x, outer.y);
            ctx.stroke();

            ctx.save();
            ctx.shadowOffsetX = 0;
            ctx.shadowOffsetY = 0;
            ctx.shadowBlur = w * 3 * glow;
            ctx.shadowColor = css(withAlpha(lumeCol, 0.7 * glow));
            ctx.strokeStyle = css(lumeCol);
            ctx.lineWidth = w * 0.4;
            ctx.lineCap = 'round';
            ctx.beginPath();
            ctx.moveTo(inner.x, inner.y);
            ctx.lineTo(outer.x, outer.y);
            ctx.stroke();
            ctx.restore();
        } else {
            ctx.save();
            ctx.shadowOffsetX = w * 0.2;
            ctx.shadowOffsetY = w * 0.4;
            ctx.shadowBlur = w * 1.2;
            ctx.shadowColor = css(theme.shadow);
            ctx.strokeStyle = css(theme.hand);
            ctx.lineWidth = w;
            ctx.lineCap = 'round';
            ctx.beginPath();
            ctx.moveTo(inner.x, inner.y);
            ctx.lineTo(outer.x, outer.y);
            ctx.stroke();
            ctx.restore();

            ctx.strokeStyle = 'rgba(199,230,184,0.35)';
            ctx.lineWidth = w * 0.4;
            ctx.lineCap = 'round';
            ctx.beginPath();
            ctx.moveTo(inner.x, inner.y);
            ctx.lineTo(outer.x, outer.y);
            ctx.stroke();
        }
    }
};

const drawHourNumbers = (cx, cy, R) => {
    const fs = R * 0.14;
    ctx.font = `bold ${fs}px ${FONT}`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';

    const nums = [12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11];
    const col = nightMode ? lumeCol : theme.num;

    for (let i = 0; i < nums.length; i++) {
        const angle = (i / 12) * Math.PI * 2;
        const p = polar(cx, cy, angle, R * 0.65);
        const t = String(nums[i]);

        if (nightMode) {
            ctx.save();
            ctx.shadowOffsetX = 0;
            ctx.shadowOffsetY = 0;
            ctx.shadowBlur = fs * 0.4 * glow;
            ctx.shadowColor = css(withAlpha(lumeCol, 0.6 * glow));
            ctx.fillStyle = css(col);
            ctx.fillText(t, p.x, p.y);
            ctx.restore();
        }
        ctx.fillStyle = css(col);
        ctx.fillText(t, p.x, p.y);
    }
};

const drawMinuteNumbers = (cx, cy, R) => {
    const fs = R * 0.065;
    ctx.font = `500 ${fs}px ${FONT}`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillStyle = css(nightMode ? withAlpha(lumeCol, 0.25) : theme.num);

    const nums = [60, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55];
    for (let i = 0; i < nums.length; i++) {
        const angle = (i / 12) * Math.PI * 2;
        const p = polar(cx, cy, angle, R * 1.02);
        ctx.fillText(String(nums[i]).padStart(2, '0'), p.x, p.y);
    }
};

const drawHand = (cx, cy, angle, length, width, R) => {
    const neckLen = R * 0.085;
    const neckStart = polar(cx, cy, angle, 0);
    const neckEnd = polar(cx, cy, angle, neckLen);
    const tip = polar(cx, cy, angle, length);

    if (nightMode) {
        ctx.strokeStyle = css(gray(0.12, 0.6));
        ctx.lineWidth = width;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckEnd.x, neckEnd.y);
        ctx.lineTo(tip.x, tip.y);
        ctx.stroke();

        ctx.lineWidth = width * 0.30;
        ctx.beginPath();
        ctx.moveTo(neckStart.x, neckStart.y);
        ctx.lineTo(neckEnd.x, neckEnd.y);
        ctx.stroke();

        ctx.save();
        ctx.shadowOffsetX = 0;
        ctx.shadowOffsetY = 0;
        ctx.shadowBlur = width * 2.5 * glow;
        ctx.shadowColor = css(withAlpha(lumeCol, 0.7 * glow));
        ctx.strokeStyle = css(lumeCol);
        ctx.lineWidth = width * 0.45;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckEnd.x, neckEnd.y);
        ctx.lineTo(tip.x, tip.y);
        ctx.stroke();
        ctx.restore();

        ctx.strokeStyle = css(lumeCol);
        ctx.lineWidth = width * 0.3;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckEnd.x, neckEnd.y);
        ctx.lineTo(tip.x, tip.y);
        ctx.stroke();
    } else {
        ctx.save();
        ctx.shadowOffsetX = width * 0.3;
        ctx.shadowOffsetY = width * 0.5;
        ctx.shadowBlur = width * 1.5;
        ctx.shadowColor = css(theme.shadow);
        ctx.strokeStyle = css(theme.hand);
        ctx.lineWidth = width;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckEnd.x, neckEnd.y);
        ctx.lineTo(tip.x, tip.y);
        ctx.stroke();
        ctx.restore();

        ctx.strokeStyle = css(theme.hand);
        ctx.lineWidth = width * 0.30;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckStart.x, neckStart.y);
        ctx.lineTo(neckEnd.x, neckEnd.y);
        ctx.stroke();

        ctx.strokeStyle = 'rgba(199,230,184,0.35)';
        ctx.lineWidth = width * 0.4;
        ctx.lineCap = 'round';
        ctx.beginPath();
        ctx.moveTo(neckEnd.x, neckEnd.y);
        ctx.lineTo(tip.x, tip.y);
        ctx.stroke();
    }
};

const drawSecondHand = (cx, cy, angle, R) => {
    const tip = polar(cx, cy, angle, R * 0.78);
    const tail = polar(cx, cy, angle + Math.PI, R * 0.15);

    ctx.strokeStyle = css(nightMode ? gray(0.25, 0.6) : theme.sec);
    ctx.lineWidth = R * 0.009;
    ctx.lineCap = 'round';
    ctx.beginPath();
    ctx.moveTo(tail.x, tail.y);
    ctx.lineTo(tip.x, tip.y);
    ctx.stroke();
};

const drawCenterDot = (cx, cy, R) => {
    const r = R * 0.035;
    ctx.fillStyle = css(nightMode ? gray(0.15) : theme.hand);
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, Math.PI * 2);
    ctx.fill();
};

const drawSecondHandRing = (cx, cy, R) => {
    const r = R * 0.035 * 0.8;
    ctx.fillStyle = css(nightMode ? gray(0.12) : theme.sec);
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, Math.PI * 2);
    ctx.fill();
};

const drawAxisPin = (cx, cy, R) => {
    const r = R * 0.01;
    ctx.fillStyle = css(gray(0.41));
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, Math.PI * 2);
    ctx.fill();
};

const drawDateWindow = (cx, cy, R, date) => {
    const day = date.getDate();
    const text = String(day);

    const fs = R * 0.075;
    const wW = R * 0.13;
    const wH = R * 0.09;
    const wX = cx + R * 0.38 - wW / 2;
    const wY = cy - wH / 2;
    const cr = R * 0.012;

    if (nightMode) {
        ctx.save();
        ctx.shadowBlur = fs * 0.4 * glow;
        ctx.shadowColor = css(withAlpha(lumeCol, 0.6 * glow));
        ctx.font = `500 ${fs}px ${FONT}`;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillStyle = css(lumeCol);
        ctx.fillText(text, wX + wW / 2, wY + wH / 2);
        ctx.restore();
        ctx.fillStyle = css(lumeCol);
        ctx.font = `500 ${fs}px ${FONT}`;
        ctx.textAlign = 'center';
        ctx.textBaseline = 'middle';
        ctx.fillText(text, wX + wW / 2, wY + wH / 2);
        return;
    }

    const isDark = luma(theme.bg) < 0.4;
    let windowBg, textColor;

    if (isDark) {
        const { r, g, b } = theme.bg;
        windowBg = css(C(r * 0.55, g * 0.55, b * 0.55));
        textColor = css(gray(0.88));
    } else {
        windowBg = 'rgba(255,255,255,0.92)';
        textColor = css(C(0.15, 0.15, 0.15));
    }

    if (isDark) {
        roundRectPath(wX, wY, wW, wH, cr);
        ctx.fillStyle = windowBg;
        ctx.fill();

        ctx.save();
        roundRectPath(wX, wY, wW, wH, cr);
        ctx.clip();

        const insetH = wH * 0.35;
        let grad = ctx.createLinearGradient(wX, wY, wX, wY + insetH);
        grad.addColorStop(0, 'rgba(0,0,0,0.4)');
        grad.addColorStop(1, 'rgba(0,0,0,0)');
        ctx.fillStyle = grad;
        ctx.fillRect(wX, wY, wW, insetH);

        const btmH = wH * 0.25;
        grad = ctx.createLinearGradient(wX, wY + wH - btmH, wX, wY + wH);
        grad.addColorStop(0, 'rgba(255,255,255,0)');
        grad.addColorStop(1, 'rgba(255,255,255,0.08)');
        ctx.fillStyle = grad;
        ctx.fillRect(wX, wY + wH - btmH, wW, btmH);

        const leftW = wW * 0.2;
        grad = ctx.createLinearGradient(wX, wY, wX + leftW, wY);
        grad.addColorStop(0, 'rgba(0,0,0,0.2)');
        grad.addColorStop(1, 'rgba(0,0,0,0)');
        ctx.fillStyle = grad;
        ctx.fillRect(wX, wY, leftW, wH);

        ctx.restore();

        ctx.save();
        roundRectPath(wX, wY, wW, wH, cr);
        ctx.clip();
        ctx.lineWidth = 1;
        ctx.strokeStyle = 'rgba(0,0,0,0.35)';
        ctx.beginPath();
        ctx.moveTo(wX + cr, wY);
        ctx.lineTo(wX + wW - cr, wY);
        ctx.stroke();
        ctx.strokeStyle = 'rgba(255,255,255,0.1)';
        ctx.beginPath();
        ctx.moveTo(wX + cr, wY + wH);
        ctx.lineTo(wX + wW - cr, wY + wH);
        ctx.stroke();
        ctx.restore();
    } else {
        ctx.save();
        ctx.shadowOffsetX = R * 0.003;
        ctx.shadowOffsetY = R * 0.005;
        ctx.shadowBlur = R * 0.012;
        ctx.shadowColor = css(theme.shadow);
        roundRectPath(wX, wY, wW, wH, cr);
        ctx.fillStyle = windowBg;
        ctx.fill();
        ctx.restore();

        ctx.save();
        roundRectPath(wX, wY, wW, wH, cr);
        ctx.clip();
        const insetH = wH * 0.3;
        let grad = ctx.createLinearGradient(wX, wY, wX, wY + insetH);
        grad.addColorStop(0, 'rgba(0,0,0,0.12)');
        grad.addColorStop(1, 'rgba(0,0,0,0)');
        ctx.fillStyle = grad;
        ctx.fillRect(wX, wY, wW, insetH);

        const btmH = wH * 0.25;
        grad = ctx.createLinearGradient(wX, wY + wH - btmH, wX, wY + wH);
        grad.addColorStop(0, 'rgba(255,255,255,0)');
        grad.addColorStop(1, 'rgba(255,255,255,0.2)');
        ctx.fillStyle = grad;
        ctx.fillRect(wX, wY + wH - btmH, wW, btmH);
        ctx.restore();

        roundRectPath(wX, wY, wW, wH, cr);
        ctx.strokeStyle = css(withAlpha(theme.num, 0.18));
        ctx.lineWidth = 0.5;
        ctx.stroke();
    }

    ctx.font = `500 ${fs}px ${FONT}`;
    ctx.textAlign = 'center';
    ctx.textBaseline = 'middle';
    ctx.fillStyle = textColor;
    ctx.fillText(text, wX + wW / 2, wY + wH / 2);
};

const drawTemperature = (W, H, text) => {
    const minSide = Math.min(W, H);
    const margin = minSide * 0.05;
    const rightEdge = W - margin;

    const tempFs = minSide * 0.032;
    ctx.font = `500 ${tempFs}px ${FONT}`;
    ctx.textAlign = 'right';
    ctx.textBaseline = 'bottom';

    if (nightMode) {
        ctx.save();
        ctx.shadowBlur = tempFs * 0.3 * glow;
        ctx.shadowColor = css(withAlpha(lumeCol, 0.5 * glow));
        ctx.fillStyle = css(withAlpha(lumeCol, 0.7));
        ctx.fillText(text, rightEdge, H - margin);
        ctx.restore();

        if (weather.city) {
            const cityFs = minSide * 0.018;
            ctx.font = `500 ${cityFs}px ${FONT}`;
            ctx.fillStyle = css(withAlpha(lumeCol, 0.4));
            ctx.fillText(weather.city, rightEdge, H - margin - tempFs - minSide * 0.004);
        }
        return;
    }

    const a = luma(theme.bg) < 0.4 ? 0.7 : 0.5;

    ctx.fillStyle = css(withAlpha(theme.num, a));
    ctx.fillText(text, rightEdge, H - margin);

    if (weather.city) {
        const cityFs = minSide * 0.018;
        ctx.font = `500 ${cityFs}px ${FONT}`;
        ctx.fillStyle = css(withAlpha(theme.num, a * 0.7));
        ctx.fillText(weather.city, rightEdge, H - margin - tempFs - minSide * 0.004);
    }
};

// ─── Main draw ─────────────────────────────────────────────────

const draw = () => {
    const dpr = window.devicePixelRatio || 1;
    const W = canvas.clientWidth;
    const H = canvas.clientHeight;

    if (canvas.width !== (W * dpr) | 0 || canvas.height !== (H * dpr) | 0) {
        canvas.width = W * dpr;
        canvas.height = H * dpr;
    }
    ctx.setTransform(dpr, 0, 0, dpr, 0, 0);

    const cx = W / 2;
    const cy = H / 2;
    const R = Math.min(W, H) * 0.44;

    theme = THEMES[settings.theme] || THEMES.turquoise;
    lumeCol = LUME_COLORS[settings.lumeColor] || LUME_COLORS.cyan;
    glow = settings.glowIntensity;
    nightMode = resolveNightMode();

    ctx.fillStyle = css(nightMode ? C(0, 0, 0) : theme.bg);
    ctx.fillRect(0, 0, W, H);

    const now = new Date();
    const hours = now.getHours() % 12;
    const minutes = now.getMinutes();
    const seconds = now.getSeconds();
    const frac = now.getMilliseconds() / 1000;

    let secVal;
    switch (settings.movement) {
        case 'quartz':     secVal = seconds; break;
        case 'mechanical': secVal = seconds + Math.floor(frac * 8) / 8; break;
        default:           secVal = seconds + frac;
    }

    drawMinuteTicks(cx, cy, R);
    drawHourCapsules(cx, cy, R);
    drawHourNumbers(cx, cy, R);
    drawMinuteNumbers(cx, cy, R);

    if (settings.showDate) {
        drawDateWindow(cx, cy, R, now);
    }

    const hourAngle   = ((hours + minutes / 60) / 12) * Math.PI * 2;
    const minuteAngle = ((minutes + secVal / 60) / 60) * Math.PI * 2;
    const secondAngle = (secVal / 60) * Math.PI * 2;

    drawHand(cx, cy, hourAngle,   R * 0.48, R * 0.045, R);
    drawHand(cx, cy, minuteAngle, R * 0.68, R * 0.045, R);
    drawCenterDot(cx, cy, R);
    drawSecondHand(cx, cy, secondAngle, R);
    drawSecondHandRing(cx, cy, R);
    drawAxisPin(cx, cy, R);

    if (settings.showTemp && weather.temp) {
        drawTemperature(W, H, weather.temp);
    }
};

// ─── Animation loop ────────────────────────────────────────────

const animate = () => {
    draw();
    requestAnimationFrame(animate);
};

// ─── Settings UI ───────────────────────────────────────────────

const initUI = () => {
    const panel = document.getElementById('panel');
    const overlay = document.getElementById('overlay');
    const settingsBtn = document.getElementById('settings-btn');

    const openPanel  = () => { panel.classList.add('open'); overlay.classList.add('visible'); };
    const closePanel = () => { panel.classList.remove('open'); overlay.classList.remove('visible'); };

    settingsBtn.addEventListener('click', () => {
        panel.classList.contains('open') ? closePanel() : openPanel();
    });
    overlay.addEventListener('click', closePanel);

    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape') closePanel();
        if ((e.key === 'f' || e.key === 'F') && !panel.classList.contains('open')) {
            if (!document.fullscreenElement) {
                document.documentElement.requestFullscreen().catch(() => {});
            } else {
                document.exitFullscreen();
            }
        }
    });

    // Tabs (Day / Night)
    const tabs = document.querySelectorAll('.tab-bar .tab');
    const tabDay = document.getElementById('tab-day');
    const tabNight = document.getElementById('tab-night');
    const autoCheckbox = document.getElementById('auto-mode');

    const switchTab = (tab) => {
        tabs.forEach(t => t.classList.remove('active'));
        document.querySelector(`.tab[data-tab="${tab}"]`).classList.add('active');
        tabDay.classList.toggle('active', tab === 'day');
        tabNight.classList.toggle('active', tab === 'night');
    };

    const syncFromSettings = () => {
        const mode = settings.nightMode;
        autoCheckbox.checked = mode === 'auto';
        switchTab(mode === 'day' ? 'day' : 'night');
    };
    syncFromSettings();

    tabs.forEach(tab => {
        tab.addEventListener('click', () => {
            const val = tab.dataset.tab;
            switchTab(val);
            if (!autoCheckbox.checked) {
                settings.nightMode = val;
            }
        });
    });

    autoCheckbox.addEventListener('change', () => {
        if (autoCheckbox.checked) {
            settings.nightMode = 'auto';
        } else {
            const activeTab = document.querySelector('.tab-bar .tab.active').dataset.tab;
            settings.nightMode = activeTab;
        }
    });

    // Theme circles
    const themeGrid = document.getElementById('theme-grid');
    for (const key of THEME_ORDER) {
        const el = document.createElement('div');
        el.className = 'color-swatch' + (settings.theme === key ? ' selected' : '');
        el.style.backgroundColor = css(THEMES[key].bg);
        el.title = key;
        el.addEventListener('click', () => {
            settings.theme = key;
            themeGrid.querySelectorAll('.color-swatch').forEach(c => c.classList.remove('selected'));
            el.classList.add('selected');
        });
        themeGrid.appendChild(el);
    }

    // Lume circles
    const lumeGrid = document.getElementById('lume-grid');
    for (const key of LUME_ORDER) {
        const el = document.createElement('div');
        el.className = 'lume-swatch' + (settings.lumeColor === key ? ' selected' : '');
        el.style.backgroundColor = css(LUME_COLORS[key]);
        el.title = key;
        el.addEventListener('click', () => {
            settings.lumeColor = key;
            lumeGrid.querySelectorAll('.lume-swatch').forEach(c => c.classList.remove('selected'));
            el.classList.add('selected');
        });
        lumeGrid.appendChild(el);
    }

    // Glow slider
    const glowSlider = document.getElementById('glow-slider');
    const glowValue = document.getElementById('glow-value');
    glowSlider.value = Math.round(settings.glowIntensity * 100);
    glowValue.textContent = `${glowSlider.value}%`;
    glowSlider.addEventListener('input', () => {
        settings.glowIntensity = parseInt(glowSlider.value, 10) / 100;
        glowValue.textContent = `${glowSlider.value}%`;
    });

    // Movement buttons
    const movBtns = document.getElementById('movement-btns');
    movBtns.querySelectorAll('button').forEach(btn => {
        if (btn.dataset.value === settings.movement) btn.classList.add('active');
        btn.addEventListener('click', () => {
            settings.movement = btn.dataset.value;
            movBtns.querySelectorAll('button').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
        });
    });

    // City dropdown
    const citySelect = document.getElementById('city-select');
    for (const city of CITIES) {
        const opt = document.createElement('option');
        opt.value = city.name;
        opt.textContent = city.name;
        if (city.name === settings.city) opt.selected = true;
        citySelect.appendChild(opt);
    }
    citySelect.addEventListener('change', () => {
        settings.city = citySelect.value;
        weather.lastFetch = 0;
        weather.temp = null;
        weather.city = citySelect.value;
        if (settings.showTemp) fetchWeather();
    });

    // Checkboxes
    const showDateEl = document.getElementById('show-date');
    showDateEl.checked = settings.showDate;
    showDateEl.addEventListener('change', () => { settings.showDate = showDateEl.checked; });

    const showTempEl = document.getElementById('show-temp');
    showTempEl.checked = settings.showTemp;
    showTempEl.addEventListener('change', () => {
        settings.showTemp = showTempEl.checked;
        if (showTempEl.checked) { weather.lastFetch = 0; fetchWeather(); }
    });

    // Cursor auto-hide
    let cursorTimer;
    document.addEventListener('mousemove', () => {
        document.body.classList.add('active');
        clearTimeout(cursorTimer);
        cursorTimer = setTimeout(() => {
            if (!panel.classList.contains('open')) {
                document.body.classList.remove('active');
            }
        }, 3000);
    });

    // Fullscreen on double-click
    canvas.addEventListener('dblclick', () => {
        if (!document.fullscreenElement) {
            document.documentElement.requestFullscreen().catch(() => {});
        } else {
            document.exitFullscreen();
        }
    });
};

// ─── Init ──────────────────────────────────────────────────────

const init = () => {
    canvas = document.getElementById('clock');
    ctx = canvas.getContext('2d');

    initUI();

    if (settings.showTemp) fetchWeather();

    setInterval(() => {
        if (settings.showTemp) fetchWeather();
    }, 60000);

    document.body.classList.add('active');
    setTimeout(() => { document.body.classList.remove('active'); }, 3000);

    requestAnimationFrame(animate);
};

document.addEventListener('DOMContentLoaded', init);

})();