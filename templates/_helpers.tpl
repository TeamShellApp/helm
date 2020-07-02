{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "teamshell-server.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamshell-nats-server.name" -}}
{{- default .Chart.Name "-nats" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamshell-storage-server.name" -}}
{{- default .Chart.Name "-storage" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamshell-events-server.name" -}}
{{- default .Chart.Name "-events" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "teamshell-ssh-server.name" -}}
{{- default .Chart.Name "-ssh" | trunc 63 | trimSuffix "-" }}
{{- end }}


{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "teamshell-server.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "teamshell-nats-server.fullname" -}}
{{ include "teamshell-server.name" . }}-nats
{{- end}}

{{- define "teamshell-storage-server.fullname" -}}
{{ include "teamshell-server.name" . }}-storage
{{- end}}

{{- define "teamshell-events-server.fullname" -}}
{{ include "teamshell-server.name" . }}-events
{{- end}}

{{- define "teamshell-ssh-server.fullname" -}}
{{ include "teamshell-server.name" . }}-ssh
{{- end}}


{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "teamshell-server.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "teamshell-server.labels" -}}
helm.sh/chart: {{ include "teamshell-server.chart" . }}
{{ include "teamshell-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "teamshell-nats-server.labels" -}}
helm.sh/chart: {{ include "teamshell-server.chart" . }}
{{ include "teamshell-nats-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "teamshell-storage-server.labels" -}}
helm.sh/chart: {{ include "teamshell-server.chart" . }}
{{ include "teamshell-storage-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "teamshell-events-server.labels" -}}
helm.sh/chart: {{ include "teamshell-server.chart" . }}
{{ include "teamshell-events-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "teamshell-ssh-server.labels" -}}
helm.sh/chart: {{ include "teamshell-server.chart" . }}
{{ include "teamshell-ssh-server.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "teamshell-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamshell-server.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "teamshell-nats-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamshell-server.name" . }}-nats
app.kubernetes.io/instance: {{ .Release.Name }}-nats
{{- end }}

{{- define "teamshell-storage-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamshell-server.name" . }}-storage
app.kubernetes.io/instance: {{ .Release.Name }}-storage
{{- end }}

{{- define "teamshell-events-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamshell-server.name" . }}-events
app.kubernetes.io/instance: {{ .Release.Name }}-events
{{- end }}

{{- define "teamshell-ssh-server.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teamshell-server.name" . }}-ssh
app.kubernetes.io/instance: {{ .Release.Name }}-ssh
{{- end }}


{{/*
Create the name of the service account to use
*/}}
{{- define "teamshell-server.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "teamshell-server.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
