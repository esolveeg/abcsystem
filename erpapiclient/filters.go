package erpapiclient

import "encoding/json"

// ERPNext accepts filters like:
// [["field","=","value"], ["other_field", "in", ["x","y"]]]
type Filter struct {
	Field string
	Op    string
	Value any
}

type Filters []Filter

type ListOptions struct {
	Fields     []string
	Filters    Filters
	OrderBy    string
	Limit      int
	LimitStart int
}

func (fs Filters) AsERPJSON() any {
	out := make([]any, 0, len(fs))
	for _, f := range fs {
		// Allow value to be passed as []any for IN ops, etc.
		out = append(out, []any{f.Field, f.Op, f.Value})
	}
	return out
}

// Debug pretty-print (optional)
func (fs Filters) String() string {
	b, _ := json.Marshal(fs.AsERPJSON())
	return string(b)
}
