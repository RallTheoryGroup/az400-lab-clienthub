var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

app.MapGet("/", () => Results.Ok(new { application = "LedgerFlow", purpose = "Identity and secrets lab" }));
app.MapGet("/health", () => Results.Ok(new { status = "Healthy" }));
app.MapGet("/version", () => Results.Ok(new { application = "LedgerFlow", version = "1.0.0" }));

app.Run();
