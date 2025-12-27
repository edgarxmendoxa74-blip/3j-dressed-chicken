import { createClient } from '@supabase/supabase-js';

const supabaseUrl = 'https://majkdgwwqtdrirjdyihh.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1hamtkZ3d3cXRkcmlyamR5aWhoIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjY1NTQxMzIsImV4cCI6MjA4MjEzMDEzMn0.yOW9pVAt-ZW-TwdsYqG5fcZjjdDhnIRcYzMmppeUVpk';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);
